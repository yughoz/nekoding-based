# scroll-world × Google Flow — Panduan Kerja (Arsitektur A: walkthrough)

Alur: kamera mengikuti kucing berjalan terus tanpa cut. **Tanpa connector** —
tiap klip (leg) dimulai dari frame terakhir klip sebelumnya. Ini cocok untuk
Veo/Flow yang hanya mendukung first-frame conditioning.

## Struktur

```
work/
  prompts/     plan.md + still_*.txt + leg*.txt (sudah dibuat)
  stills/      hasil image dari Flow (png, 3:2 landscape)
  clips/       hasil video dari Flow (mp4, mentah): leg1.mp4 .. leg4.mp4
  frames/      frame first/last hasil ekstraksi
assets/vid/    output final yang dibaca website
scrub-engine.js, index-template.html  (engine dari scroll-world)
```

## Langkah

### 1. Stills di Google Flow (4 gambar)
- Generate dari `work/prompts/still_<name>.txt` (home, park, site, factory).
  Style preamble harus identik — jangan edit antar scene.
- Aspect 3:2 landscape, resolusi tertinggi.
- Download PNG ke `work/stills/<name>.png`.
- Cek kohesi: semua scene harus terasa satu dunia. Re-roll yang melenceng.
- Still dipakai sebagai poster section + start image leg 1 (home saja).

### 2. Leg 1 di Google Flow
- Image-to-video: first frame = `work/stills/home.png`.
- Prompt = isi `work/prompts/leg1.txt` (baris pertama "LEG 1 —" JANGAN
  ikut dicopy; mulai dari "Single continuous...").
- Setting: 16:9, 8 detik.
- Download ke `work/clips/leg1.mp4`.

### 3. Frame handoff (otomatis)
```bash
./frames.sh work/clips/leg1.mp4 leg1
```

### 4. Leg 2–4 di Google Flow (ulangi pola yang sama)
- Leg N: first frame = `work/frames/last_leg(N-1).png`,
  prompt = `work/prompts/leg(N).txt`.
- Download ke `work/clips/legN.mp4`, lalu `./frames.sh work/clips/legN.mp4 legN`.
- **QA sebelum lanjut**: frame terakhir tiap leg harus terbaca sebagai glide
  maju yang tenang (tidak ada blur menyamping / orbit setengah jalan / sudut
  kamera berubah). Kalau rusak → re-roll leg itu saja.
- Kucing harus selalu terlihat berjalan di depan kamera — kalau hilang di
  tengah leg, re-roll.

### 5. Encode (otomatis, per klip)
```bash
./encode.sh work/clips/leg1.mp4 leg1
./encode.sh work/clips/leg2.mp4 leg2
./encode.sh work/clips/leg3.mp4 leg3
./encode.sh work/clips/leg4.mp4 leg4
```

### 6. Rakit halaman
Copy `index-template.html` → `index.html`, isi config:
- 4 sections (home, park, site, factory) dengan copy dari
  `work/prompts/plan.md`.
- `sections[k].still` = path ke still poster (convert webp dulu jika mau).
- `sections[k].clip = assets/vid/legN.mp4`, `clipMobile` = varian `-m`.
- Walkthrough = connectors kosong.

Serve: `python3 -m http.server` (video tidak scrubbable via file://).

## Aturan penting
- Frame handoff WAJIB dari video yang sudah dirender (`frames.sh`),
  bukan dari still asli.
- Satu model (Veo) untuk seluruh chain — jangan campur.
- First frame = satu-satunya pengikat antar klip; jangan lewati QA frame.
