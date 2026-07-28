import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/application/settings_providers.dart';

class NotificationSettingsTile extends ConsumerWidget {
  const NotificationSettingsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return settings.maybeWhen(
      data: (value) => SwitchListTile(
        value: value.notificationsEnabled,
        secondary: const Icon(Icons.notifications_active),
        title: const Text('Charging notifications'),
        subtitle: const Text(
          'Receive booking reminders and charging updates',
        ),
        onChanged: (enabled) {
          ref.read(appSettingsProvider.notifier).update(
                value.copyWith(notificationsEnabled: enabled),
              );
        },
      ),
      orElse: () => const ListTile(
        leading: CircularProgressIndicator(),
        title: Text('Loading notification settings'),
      ),
    );
  }
}
