import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/firebase_notification_service.dart';
import '../data/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => FirebaseNotificationService(),
);

final notificationInitializationProvider =
    FutureProvider<String?>((ref) {
  return ref.watch(notificationServiceProvider).initialize();
});

final foregroundNotificationProvider =
    StreamProvider<RemoteMessage>((ref) {
  return ref.watch(notificationServiceProvider).foregroundMessages;
});

final openedNotificationProvider =
    StreamProvider<RemoteMessage>((ref) {
  return ref.watch(notificationServiceProvider).openedMessages;
});
