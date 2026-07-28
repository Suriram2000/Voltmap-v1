import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';
import 'settings_repository.dart';

class LocalSettingsRepository implements SettingsRepository {
  const LocalSettingsRepository();

  @override
  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme_mode');

    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (item) => item.name == theme,
        orElse: () => ThemeMode.system,
      ),
      notificationsEnabled:
          prefs.getBool('notifications_enabled') ?? true,
      locationEnabled: prefs.getBool('location_enabled') ?? true,
      vehicleName: prefs.getString('vehicle_name') ?? '',
      vehicleRangeKm: prefs.getInt('vehicle_range_km') ?? 350,
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', settings.themeMode.name);
    await prefs.setBool(
      'notifications_enabled',
      settings.notificationsEnabled,
    );
    await prefs.setBool('location_enabled', settings.locationEnabled);
    await prefs.setString('vehicle_name', settings.vehicleName);
    await prefs.setInt('vehicle_range_km', settings.vehicleRangeKm);
  }
}
