import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  late PusherChannelsFlutter pusher;

  PusherService._privateConstructor();

  static final PusherService instance = PusherService._privateConstructor();

  Future<void> initPusher(String idUser, Function(PusherEvent) onEvent , String channelName) async {
    pusher = PusherChannelsFlutter();
    try {
      await pusher.init(
        apiKey: "e8dd0273a5e8de2d483b",
        cluster: "ap1",
        onConnectionStateChange: (currentState, previousState) {
          print("Connection State Status: $currentState");
        },
        onError: (message, code, error) {
          print("Pusher Error : $message");
        },
        onEvent: onEvent,
      );
      await pusher.connect();
      await pusher.subscribe(channelName: channelName);
    } catch (e) {
      print("Error initializing Pusher : $e");
    }
  }
}
