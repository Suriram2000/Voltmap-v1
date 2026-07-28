import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/notifications/application/notification_providers.dart';

class NotificationBootstrap {
  const NotificationBootstrap._();

  static Future<void> initialize(WidgetRef ref) async {
    await ref.read(notificationInitializationProvider.future);
  }
}
