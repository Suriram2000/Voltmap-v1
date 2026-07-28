import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/settings/application/settings_providers.dart';

class VoltMapApp extends ConsumerWidget {
  const VoltMapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VoltMap',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode:
          settings.valueOrNull?.themeMode ?? ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
