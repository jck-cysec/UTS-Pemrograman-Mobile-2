# 🍽️ Aplikasi UTS (Flutter/Dart)

<p align="center">
<img src="https://img.shields.io/badge/State%20Management-Cubit%20(Bloc)-informational?style=for-the-badge&logo=dart" alt="Cubit Badge"/>
<img src="https://img.shields.io/badge/Flutter%20Version-3.13.0-blue?style=for-the-badge&logo=flutter" alt="Flutter Version Badge"/>
<img src="https://img.shields.io/github/license/USERNAME/REPO?style=for-the-badge" alt="License Badge"/>
</p>

Aplikasi ini adalah sebuah aplikasi Flutter sederhana untuk sistem pemesanan makanan/minuman, yang di dalamnya terdapat fitur menampilkan daftar menu, memilih kategori, menambahkan pesanan, serta melihat ringkasan order. Struktur project mencakup model MenuModel untuk data menu, state management menggunakan OrderCubit, halaman-halaman seperti Home, Category Stack, dan Order Summary, serta widget khusus seperti MenuCard untuk menampilkan item menu. Aplikasi ini dirancang sebagai demonstrasi alur pemesanan modern yang rapi dan modular, cocok untuk tugas UTS atau proyek pembelajaran Flutter.

---

## 📝 Informasi Mahasiswa

| Detail    | Keterangan                   |
| :-------- | :--------------------------- |
| **Nama**  | Haidir Mirza Ahmad Zacky          |
| **NIM**   | 23552011072 |
| **Kelas** | TIF RP 23 CNS B            |

---

## 🚀 Fitur Utama & Keunggulan Arsitektur

### 1. State Management dengan Cubit untuk Logika Diskon Dinamis (10 Poin)

Kami menggunakan **Cubit** (dari paket `flutter_bloc`) untuk mengelola status transaksi. Pendekatan ini sangat membantu pengelolaan transaksi dengan logika diskon dinamis melalui:

* **Sentralisasi State:** Semua data pesanan (item, jumlah, diskon) disimpan dalam satu state yang mudah dikelola (`OrderState` dalam `order_cubit.dart`).
* **Reactive Updates:** Setiap perubahan pesanan (tambah/kurang item, update *quantity*) otomatis **menghitung ulang total** dan **diskon** yang berlaku.
* **Separation of Concerns:** Logika bisnis perhitungan diskon terpisah sepenuhnya dari UI, membuat kode lebih **maintainable** dan **bersih**.
* **Predictable State Changes:** Setiap aksi (`addToOrder`, `removeFromOrder`) menghasilkan state baru yang *immutable*, meminimalkan *bug* dan memudahkan *debugging*.
* **Easy Testing:** Logika bisnis dapat di-*test* secara independen tanpa *User Interface*.

### 2. Perbedaan Diskon Per Item vs Diskon Total Transaksi (10 Poin)

Implementasi arsitektur ini dirancang untuk dapat mengakomodasi dua jenis skema diskon yang berbeda:

#### Diskon Per Item:

* Diterapkan pada **harga masing-masing produk** sebelum dijumlahkan ke total.
* **Contoh:** Nasi Goreng Rp20.000 diskon 20% = Rp16.000.
* **Dihitung:** `harga_final = harga_asli * (1 - diskon_item)`.

#### Diskon Total Transaksi:

* Diterapkan pada **keseluruhan nilai belanja** setelah semua item dijumlahkan.
* **Contoh:** Total Rp150.000 dapat diskon 10% menjadi Rp135.000.
* **Dihitung** setelah semua item dijumlahkan.

### 3. Manfaat Widget Stack pada Tampilan Kategori Menu (10 Poin)

Penggunaan **Widget Stack** memberikan manfaat desain yang signifikan:

* **Layering:** Dapat menumpuk elemen UI (misalnya *badge* "Promo" di atas gambar kategori) untuk efek visual yang kompleks.
* **Positioning Fleksibel:** Menggunakan `Positioned` *widget* untuk menempatkan elemen di lokasi spesifik.
* **Visual Appeal:** Membuat tampilan lebih menarik dengan *overlay effects*.
* **Space Efficient:** Memanfaatkan ruang layar dengan optimal.

---

## 📂 Struktur Proyek yang Lengkap

Proyek ini mengadopsi struktur arsitektur yang bersih, modular, dan didorong oleh pola **BLoC/Cubit**.

```
lib
├── blocs                 # State Management Logic (BLoC/Cubit)
│   └── order_cubit.dart  # Kelas Cubit: Logika bisnis diskon dan kalkulasi total.
├── models                # Data Structures (Immutable Data Objects)
│   └── menu_model.dart   # Model data item menu.
├── pages                 # Full Screen Views/Containers
│   ├── order_home_page.dart   # Tampilan utama daftar menu.
│   ├── order_stack_page.dart  # Halaman dengan implementasi Stack (misalnya, kategori).
│   └── order_summary_page.dart # Halaman ringkasan akhir pesanan.
├── widgets               # Reusable UI Components
│   └── menu_card.dart        # Komponen untuk menampilkan item menu.
└── main.dart             # Entry Point Aplikasi
```

## 🤝 Kontribusi

Thank you very much sudah melihat project UTS ini
