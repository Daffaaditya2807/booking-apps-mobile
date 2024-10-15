import 'package:get/get.dart';

class DiceBearController extends GetxController {
  // Observable untuk URL avatar
  var avatarUrl = ''.obs;

  // URL base dari API DiceBear
  static const String baseUrl =
      'https://api.dicebear.com/9.x/avataaars-neutral/svg';

  // Function untuk mengambil gambar acak dari API
  Future<void> fetchRandomAvatar() async {
    try {
      // Anda bisa menambahkan seed atau biarkan kosong untuk random avatar
      final String seed = DateTime.now().millisecondsSinceEpoch.toString();
      final String url = '$baseUrl?seed=$seed&size=50';

      // Simpan URL ke observable avatarUrl
      avatarUrl.value = url;
    } catch (e) {
      // Handle error
      print('Failed to fetch avatar: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRandomAvatar(); // Ambil avatar pertama kali saat controller di-init
  }
}
