import 'package:flutter/material.dart';

class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.notificationsEnabled = true,
    this.locationEnabled = true,
    this.vehicleName = '',
    this.vehicleRangeKm = 350,
  });

  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final bool locationEnabled;
  final String vehicleName;
  final int vehicleRangeKm;

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? locationEnabled,
    String? vehicleName,
    int? vehicleRangeKm,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled:
          notificationsEnabled ?? this.notificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleRangeKm: vehicleRangeKm ?? this.vehicleRangeKm,
    );
  }
}
