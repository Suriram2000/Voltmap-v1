import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

class FirebaseNotificationService implements NotificationService {
  FirebaseNotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  })  : _messaging = messaging ?? FirebaseMessaging.instance,
        _localNotifications =
            localNotifications ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  static const _channel = AndroidNotificationChannel(
    'voltmap_charging_alerts',
    'Charging Alerts',
    description:
        'Booking, charger availability, and charging-session alerts.',
    importance: Importance.high,
  );

  @override
  Stream<RemoteMessage> get foregroundMessages =>
      FirebaseMessaging.onMessage;

  @override
  Stream<RemoteMessage> get openedMessages =>
      FirebaseMessaging.onMessageOpenedApp;

  @override
  Future<String?> initialize() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidInitialization =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosInitialization = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidInitialization,
        iOS: iosInitialization,
      ),
    );

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(_channel);

    FirebaseMessaging.onMessage.listen(_showForegroundMessage);

    return _messaging.getToken();
  }

  Future<void> _showForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;

    if (notification == null) return;

    await _localNotifications.show(
      notification.hashCode,
      notification.title ?? 'VoltMap',
      notification.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'voltmap_charging_alerts',
          'Charging Alerts',
          channelDescription:
              'Booking, charger availability, and charging-session alerts.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.data['route'] as String?,
    );
  }

  @override
  Future<void> subscribeToStation(String stationId) {
    return _messaging.subscribeToTopic('station_$stationId');
  }

  @override
  Future<void> unsubscribeFromStation(String stationId) {
    return _messaging.unsubscribeFromTopic('station_$stationId');
  }
}
