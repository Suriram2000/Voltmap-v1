import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settings.when(
        data: (value) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Appearance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: value.themeMode,
              title: const Text('Use device setting'),
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        value.copyWith(themeMode: mode),
                      );
                }
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: value.themeMode,
              title: const Text('Light mode'),
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        value.copyWith(themeMode: mode),
                      );
                }
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: value.themeMode,
              title: const Text('Dark mode'),
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        value.copyWith(themeMode: mode),
                      );
                }
              },
            ),
            const Divider(),
            SwitchListTile(
              value: value.notificationsEnabled,
              title: const Text('Notifications'),
              onChanged: (enabled) {
                ref.read(appSettingsProvider.notifier).update(
                      value.copyWith(
                        notificationsEnabled: enabled,
                      ),
                    );
              },
            ),
            SwitchListTile(
              value: value.locationEnabled,
              title: const Text('Location services'),
              onChanged: (enabled) {
                ref.read(appSettingsProvider.notifier).update(
                      value.copyWith(locationEnabled: enabled),
                    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Vehicle'),
              subtitle: Text(
                value.vehicleName.isEmpty
                    ? 'Not configured'
                    : value.vehicleName,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.battery_full),
              title: const Text('Estimated range'),
              subtitle: Text('${value.vehicleRangeKm} km'),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Unable to load settings: $error'),
        ),
      ),
    );
  }
}
