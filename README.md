# GymYuk 🏋️‍♂️

GymYuk adalah aplikasi mobile berbasis Android yang membantu pengguna menemukan gym-gym di sekitar lokasi mereka, lengkap dengan informasi harga, fasilitas, serta fitur pendaftaran membership bulanan maupun tahunan.

## ✨ Fitur Utama

### 🔐 Autentikasi
- **Login & Registrasi** menggunakan **Firebase** sebagai database, sehingga data akun pengguna tersimpan secara real-time dan aman.
- Alur aplikasi diawali dengan **Logo/Splash Screen** → **Onboarding** → **Login/Registrasi**.
- Jika pengguna sudah pernah login sebelumnya, alur onboarding dan login akan dilewati — setelah splash screen, pengguna langsung diarahkan ke halaman **Home**, karena sesi/data sudah tersimpan di database.

### 🏠 Home
- Menampilkan daftar **gym unggulan** (masih menggunakan data dummy).
- Fitur **pencarian** untuk mencari gym-gym unggulan.
- Ikon **notifikasi** di pojok kanan atas yang menampilkan status pembayaran (berhasil/gagal).

### 🧭 Explore
- Menampilkan **peta (maps)** interaktif berisi gym-gym terdekat di sekitar lokasi pengguna.
- Setiap titik gym dapat di-klik untuk melihat detail gym, termasuk **fasilitas** dan **harga**.
- Pengguna dapat langsung melakukan **pembayaran secara cash** dari halaman detail gym.

### 💪 Workout
- Menyediakan **artikel dan berita seputar kesehatan**, mulai dari nutrisi, tips latihan, hingga topik kesehatan lainnya.

### 👤 Profile
- Pengguna dapat mengisi dan mengelola data pribadi: **nama, email, nomor telepon, foto profil**, serta data fisik seperti **berat badan, tinggi badan, dan usia**.
- Data fisik tersebut otomatis dikalkulasikan untuk menentukan status **BMI (Body Mass Index)** — apakah termasuk kategori normal atau tidak.
- Fitur **riwayat pembayaran/reward membership** untuk memantau transaksi.
- Fitur **logout** untuk keluar dari akun.

## 🔄 Alur Aplikasi

```
Splash Screen → Onboarding → Login/Registrasi → Home
                                                   ├── Explore
                                                   ├── Workout
                                                   └── Profile
```

> Catatan: Jika pengguna sudah login sebelumnya, alur **Onboarding** dan **Login** akan otomatis dilewati setelah Splash Screen.

## 🛠️ Teknologi yang Digunakan
- **Platform:** Android
- **Database:** Firebase (Login & Registrasi)
- **Peta:** Maps untuk menampilkan lokasi gym terdekat

## 📌 Status Data
- Data gym unggulan di halaman Home masih berupa **data dummy**.
- Data gym pada halaman Explore (lokasi, fasilitas, harga) juga menggunakan data dummy untuk keperluan demo.
- Data akun pengguna (login/registrasi) sudah **tersimpan secara real ke Firebase**.

---
*README ini dapat disesuaikan lebih lanjut sesuai kebutuhan repository (instalasi, struktur folder, kontribusi, dsb).*
