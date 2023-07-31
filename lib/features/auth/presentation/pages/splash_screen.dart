import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mro/main_basics.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    launchSplashScreen();
  }

  void launchSplashScreen() {
    // Set 3 second timer for Splash Screen
    Timer(const Duration(seconds: 3), () {
      // Navigate To Main Screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(children: [
            Image.asset("assets/images/img_splash.png"),
            const Spacer(),
            Image.asset("assets/images/img_scan_it_logo.png")
          ]),
        ),
      ),
    );
  }
}
