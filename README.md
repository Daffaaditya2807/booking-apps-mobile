# AntreQu Apps 🚀

**AntreQu Apps** adalah aplikasi modern untuk pemesanan (booking) yang terintegrasi dengan:  
- **Website** sebagai **Admin**  
- **Mobile App** sebagai **User**  

Aplikasi ini dirancang untuk memberikan pengalaman pemesanan yang mudah, cepat, dan efisien!

---

## 📋 Konfigurasi Backend untuk Mobile App
Untuk mengatur **base URL** pada aplikasi mobile, lakukan pengaturan di file berikut:

**Lokasi File:**
```
Booking-apps-mobile -> lib -> data -> data_sources -> api.dart
```

### 🔗 Base URL untuk Server **LIVE**
Gunakan URL berikut untuk server **LIVE**:  
```dart
String http = "https://antreeze.kingperseus.online";
```

### 🔗 Base URL untuk Server **LOCAL**
Gunakan URL berikut untuk server **LOCAL** (IP Address Anda):  
```dart
String http = "http://192.168.xxx.xx:8000";
```

> **Tips:**  
> - Untuk mendapatkan **IPv4 Address**, buka terminal/command prompt dan ketikkan:  
>   ```bash
>   ipconfig
>   ```
> - Gantilah `xxx.xx` dengan IP Address lokal Anda.

---

## 🛠️ Menjalankan Backend secara Lokal
Jika menggunakan **server lokal**, pastikan Anda menjalankan backend dari repositori berikut:  
[AntreeZe Backend Repository](https://github.com/faris2000111/AntreeZe)

### Langkah-langkah:
1. **Clone repo backend** ke komputer Anda:  
   ```bash
   git clone https://github.com/faris2000111/AntreeZe
   ```

2. **Masuk ke direktori project backend** menggunakan terminal:  
   ```bash
   cd AntreeZe
   ```

3. Jalankan perintah berikut untuk memulai server backend:  
   ```bash
   php artisan serve --host=ip4address
   ```

   Gantilah `ip4address` dengan **IPv4 Address** lokal Anda yang diperoleh sebelumnya.

---



## 📱 Panduan Compile ke APK & AAB

Berikut langkah-langkah untuk meng-compile aplikasi Flutter ke format **APK** dan **AAB** agar dapat diuji dengan **Base URL** versi **LIVE**:

### 1️⃣ **Prasyarat**
Pastikan perangkat Anda memiliki:
- **Flutter SDK** (versi terbaru).  
- **Android Studio** (untuk tools build).  
- **Keystore** (untuk menandatangani APK/AAB jika ingin di-publish).  
- Dependency project sudah terpasang dengan perintah:  
  ```bash
  flutter pub get
  ```

---

### 2️⃣ **Langkah-langkah Build APK**
1. **Pastikan Base URL diatur ke LIVE**  
   Edit file `api.dart` seperti yang telah dijelaskan sebelumnya:
   ```dart
   String http = "https://antreeze.kingperseus.online";
   ```

2. **Jalankan Command Build**  
   Masukkan perintah berikut di terminal untuk membuat APK:
   ```bash
   flutter build apk --release
   ```

3. **Hasil Build**  
   File APK akan tersedia di:  
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

4. **Install di Perangkat**  
   Salin file APK ke perangkat Anda dan install untuk mencoba aplikasi.

---

### 3️⃣ **Langkah-langkah Build AAB (untuk Play Store)**
1. **Pastikan Base URL diatur ke LIVE**  
   Seperti langkah sebelumnya, atur `api.dart` ke URL versi **LIVE**.

2. **Jalankan Command Build AAB**  
   Masukkan perintah berikut di terminal untuk membuat AAB:
   ```bash
   flutter build appbundle --release
   ```

3. **Hasil Build**  
   File AAB akan tersedia di:  
   ```
   build/app/outputs/bundle/release/app-release.aab
   ```

4. **Siap untuk Upload ke Play Store**  
   Gunakan file AAB untuk proses pengunggahan di Google Play Console.

---

## 💡 Tips dan Catatan
- **Debugging:** Jika perlu memeriksa error, gunakan mode debug:  
  ```bash
  flutter run
  ```
- **Key Signing:** Untuk keperluan publishing, tambahkan konfigurasi keystore Anda pada file:  
  ```
  android/app/build.gradle
  ```
  Contoh konfigurasi:
  ```gradle
  android {
      ...
      signingConfigs {
          release {
              storeFile file('keystore.jks')
              storePassword 'password'
              keyAlias 'alias'
              keyPassword 'password'
          }
      }
      buildTypes {
          release {
              signingConfig signingConfigs.release
          }
      }
  }



## 🎉 Siap Digunakan
Sekarang Anda siap menjalankan **AntreQu Apps** dengan lancar! Pastikan backend dan aplikasi mobile sudah terhubung dengan benar.  

Jangan ragu untuk memberikan bintang ⭐ pada repositori ini jika Anda merasa terbantu!  
Terima kasih telah menggunakan **AntreQu Apps**! 🎉
