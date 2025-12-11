Deployment — Kasir Warung

Rekomendasi singkat
- Untuk mudah dan cepat: gunakan Fly.io (mendukung Docker + persistent volume).
- Alternatif: Render (pastikan persistent disk jika ingin menyimpan SQLite), atau pindah ke PostgreSQL dan deploy ke Railway/Heroku.

Pilihan direkomendasikan: Fly.io (mendukung volume untuk SQLite)
1. Siapkan akun: https://fly.io dan install `flyctl`.
2. Dari folder project (`web`) jalankan:

```bash
# login
flyctl auth login

# inisialisasi aplikasi (ikuti prompt)
flyctl launch --name kasir-warung --region sjc --no-deploy

# buat volume untuk menyimpan data.db
flyctl volumes create kasir-data --size 1 --region sjc

# edit fly.toml: tambahkan mount untuk volume, contoh di bawah
```

Tambahkan di `fly.toml` (folder project) di bagian [[mounts]]:
```toml
[[mounts]]
source = "kasir-data"
destination = "/app/data"
```

(Ubah `destination` jika path DB Anda berbeda; project ini menyimpan `data.db` di `/app/data.db`.)

3. Build & deploy

```bash
flyctl deploy
```

Catatan: setelah deploy, pastikan `data.db` dipetakan ke volume (path /app/data.db). Jika aplikasi menyimpan `data.db` di lokasi lain, sesuaikan mount.

Alternatif: Render
- Buat service Web di Render dari GitHub repo. Jika ingin SQLite persist, pastikan pakai disk persisten (biaya berbayar) atau gunakan database hosted (Postgres) dan ubah kode agar menggunakan Postgres.

Opsional - pindah ke PostgreSQL (lebih cocok produksi)
- Buat database Postgres di Railway/Render/Heroku
- Ganti `models/database.js` untuk gunakan `pg` dan query SQL, atau gunakan library ORM seperti `knex`/`sequelize` untuk migrasi.

Langkah cepat (local -> Docker -> VPS)
- Build image & jalankan di VPS/Docker host:

```bash
# build
docker build -t kasir-warung:latest .
# run (mount data file)
docker run -d -p 3000:3000 -v $PWD/data.db:/app/data.db --name kasir-warung kasir-warung:latest
```

Jika Anda mau, saya bisa:
- Menambahkan `Docker Compose` untuk memudahkan (dengan volume),
- Membuat `fly.toml` contoh dan file konfigurasi deploy, atau
- Migrasi ke PostgreSQL dan menyiapkan skrip migrasi.

Mau saya lanjutkan ke salah satu opsi di atas? Sebutkan pilihan (Fly.io, Render, VPS/Docker, atau migrasi PostgreSQL).