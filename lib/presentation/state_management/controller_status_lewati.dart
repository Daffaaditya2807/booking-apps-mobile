import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ControllerStatusLewati extends GetxController {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  RxInt unreadCount = 0.obs;
  RxList<Map<String, dynamic>> lewatiList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  // Listen to real-time updates for unread notifications
  void listenToUnreadNotifications(String userId) {
    _dbRef.child('lewati').onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        int count = 0;
        lewatiList.clear();

        values.forEach((key, value) {
          if (value['id_users'] == userId) {
            Map<String, dynamic> item = Map<String, dynamic>.from(value);
            item['key'] = key;
            lewatiList.add(item);
          }
        });

        values.forEach((key, value) {
          if (value['id_users'] == userId && value['read'] == "false") {
            count++;
          }
        });

        unreadCount.value = count;
      }
    });
  }

  // Mark notifications as read
  Future<void> markNotificationsAsRead(String userId) async {
    final lewatiRef = _dbRef.child('lewati');

    // Get all notifications for this user
    final snapshot =
        await lewatiRef.orderByChild('id_users').equalTo(userId).get();

    if (snapshot.value != null) {
      Map<dynamic, dynamic> notifications = snapshot.value as Map;

      // Update each unread notification
      notifications.forEach((key, value) async {
        if (value['read'] == "false") {
          await lewatiRef.child(key).update({'read': "true"});
        }
      });
    }
  }

  Future<void> deleteData(String id) async {
    isLoading(true);
    try {
      final ref = _dbRef.child('lewati').child(id);
      lewatiList.removeWhere((element) => element['id_booking'] == id);
      await ref.remove();
      log("berhasil dihapus $id");
    } catch (e) {
      log("gagal dihapus $e");
    } finally {
      isLoading(false);
    }
  }

  // Get notification details for display
  Map<String, dynamic>? getNotificationDetails(String bookingId) {
    return lewatiList
        .firstWhereOrNull((element) => element['id_booking'] == bookingId);
  }
}
