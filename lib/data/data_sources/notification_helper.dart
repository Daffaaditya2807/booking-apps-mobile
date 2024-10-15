import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationHelper {
  Future<void> initializeAppMessaging() async {
    FirebaseMessaging.instance;
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Received a message in foreground: ${message.notification?.title}');
    // });
    AwesomeNotifications().initialize(
      'resource://drawable/notification',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          playSound: true,
          channelShowBadge: true,
          enableVibration: true,
        )
      ],
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void showNotification(String? title, String? body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        badge: 1,
        actionType: ActionType.KeepOnTop,
        icon: "resource://drawable/notification",
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  void showOverlayNotification(String title, String body) {
    showSimpleNotification(
      Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        body,
        style: TextStyle(color: Colors.black),
      ),
      leading: const Icon(
        Icons.info_rounded,
        color: Colors.black,
      ),
      background: Colors.white,
      slideDismiss: true,
      duration: Duration(seconds: 3),
      slideDismissDirection: DismissDirection.up,
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void requestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
}
