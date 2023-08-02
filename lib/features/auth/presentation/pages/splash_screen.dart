import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../config/app_constants.dart';
import '../../../widgets/my_custom_widget.dart';

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
    Timer(const Duration(seconds: 2), () {
      // Navigate To Main Screen
      Navigator.pushReplacementNamed(context, AppConstants.routeLanding);
      // Navigator.pushNamedAndRemoveUntil(context, AppConstants.routeLanding, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/images/img_splash.png"),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ScanItLogoImage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
