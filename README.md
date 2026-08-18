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

## Deploy

Situs ini **statis murni — tidak perlu build step** (tanpa Node, tanpa
bundler). Yang ada di repo sudah bentuk finalnya. Satu-satunya syarat:
file harus di-serve lewat HTTP, bukan dibuka via `file://`.

### 1. VPS sendiri (nginx / Apache)

```bash
rsync -avz --exclude work/ --exclude .git \
  scroll-world/ user@server:/var/www/nekoding-based/
```

Server block nginx:

```nginx
server {
    listen 80;
    server_name based.nekoding.xyz;
    root /var/www/nekoding-based;
    index index.html;
}
```

### 2. Netlify / Vercel / Cloudflare Pages

Drag-and-drop folder ini ke Netlify Drop, atau connect repo ini.
Build command: **(kosong)** · Output directory: `/` (root).

### 3. GitHub Pages

Settings → Pages → Source: `main` / root →
live di `https://yughoz.github.io/nekoding-based/`.

> Tips: aktifkan gzip/brotli untuk `.html`/`.js`, tapi **jangan**
> kompres ulang `.mp4` (sudah h264). Total video ~49MB — kalau target
> pengunjung internasional, taruh Cloudflare di depan VPS.

