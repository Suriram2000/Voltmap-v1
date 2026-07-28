import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class NotificationService {
  Future<String?> initialize();
  Stream<RemoteMessage> get foregroundMessages;
  Stream<RemoteMessage> get openedMessages;
  Future<void> subscribeToStation(String stationId);
  Future<void> unsubscribeFromStation(String stationId);
}
