# AntreQu Apps 🚀

**AntreQu Apps** adalah aplikasi modern untuk pemesanan (booking) yang terintegrasi dengan:  
- **Website** sebagai **Admin**  
- **Mobile App** sebagai **User**  

Aplikasi ini dirancang untuk memberikan pengalaman pemesanan yang mudah, cepat, dan efisien!

---

## 📋 Konfigurasi Backend untuk Mobile App
Untuk mengatur **base URL** pada aplikasi mobile, Anda dapat melakukannya di file berikut:

**Lokasi File:**
Booking-apps-mobile -> lib -> data -> data_sources -> api.dart

### 🔗 Base URL untuk Server **LIVE**
Gunakan URL berikut untuk server **LIVE**:

String http = "https://antreeze.kingperseus.online";


### 🔗 Base URL untuk Server **LOCAL**
Gunakan URL berikut untuk server **LOCAL**:
String http = "http://192.168.xxx.xx:8000";

Tips:
Untuk mendapatkan IPv4 Address, buka terminal/command prompt dan ketikkan:
ipconfig
Gantilah xxx.xx dengan IP Address lokal Anda.

🛠️ Menjalankan Backend secara Lokal
Jika menggunakan server lokal, pastikan Anda menjalankan backend dari repositori berikut:
AntreeZe Backend Repository
https://github.com/faris2000111/AntreeZe

Langkah-langkah:
Clone repo backend ke komputer Anda.

Masuk ke direktori project backend menggunakan terminal.

Jalankan perintah berikut untuk memulai server backend:
php artisan serve --host=ip4address
Gantilah ip4address dengan IP Address lokal Anda yang diperoleh sebelumnya.

🎉 Sekarang Anda siap menjalankan AntreQu Apps dengan lancar! 🎉
Jangan ragu untuk memberikan bintang ⭐ pada repositori ini jika Anda merasa terbantu!
