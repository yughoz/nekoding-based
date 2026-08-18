# nekoding-based

Landing page portofolio scroll-driven — kamera mengikuti kucing berjalan dari
rumah → taman → gedung renovasi → pabrik robotik. Dibuat dengan metode
[scroll-world](https://github.com/oso95/scroll-world); video dirender di Google
Flow (Veo), dirakit dengan scrub engine vanilla-JS.

## Struktur

- `index.html` — halaman + config section (copy, warna, pacing)
- `scrub-engine.js` — engine scroll-scrub (dari scroll-world, tanpa modifikasi)
- `assets/` — poster webp + video mp4 (desktop & varian mobile)
- `work/` *(tidak di-push)* — pipeline lokal: prompt, render mentah, frame QA

## Jalankan lokal

```bash
python3 -m http.server 8923
# buka http://localhost:8923 — video butuh HTTP server, tidak jalan via file://
```

## Mengubah copy / warna

Semua teks section ada di object `sections` dalam `index.html`
(`eyebrow`, `title`, `body`, `tags`, `cta`). Warna per-section via `accent`.
