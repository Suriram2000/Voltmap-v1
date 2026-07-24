import 'package:flutter/material.dart';

class VoltMapApp extends StatelessWidget {
  const VoltMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoltMap',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C853),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C853),
          brightness: Brightness.dark,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [

              Color(0xff00C853),

              Color(0xff0091EA),

            ],

          ),

        ),

        child: const Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(
                Icons.ev_station,
                size: 100,
                color: Colors.white,
              ),

              SizedBox(height: 24),

              Text(
                "VoltMap",
                style: TextStyle(
                  fontSize: 42,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "One App. Every EV Charger.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              SizedBox(height: 40),

              CircularProgressIndicator(
                color: Colors.white,
              )

            ],

          ),

        ),

      ),

    );
  }
}

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("VoltMap"),
      ),

      body: const Center(

        child: Text(

          "Welcome to VoltMap",

          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),

        ),

      ),

    );

  }

}
