import 'package:flutter/material.dart';

import 'features/splash/splash_screen.dart';

class VoltMapApp extends StatelessWidget {
  const VoltMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF00A86B);

    return MaterialApp(
      title: 'VoltMap',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandGreen,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandGreen,
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
