import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../config/constants/app_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
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
    Timer(const Duration(seconds: AppConstants.splashTimeOut), () {
      final pref = MroSharedPreferenceProvider.of(context)?.preference;
      print("TAG_PREF_SPLASH ${pref?.getBool(AppConstants.prefKeyIsLoggedIn)}");
      print("TAG_USER_SCHEMA ${pref?.getString(AppConstants.prefKeyUserSchema)}");

      var isLogin = pref?.getBool(AppConstants.prefKeyIsLoggedIn);
      if (isLogin == true) {
        // Navigate To Main Screen
        Navigator.pushReplacementNamed(context, AppConstants.routeHome);
      } else {
        // Navigate To Main Screen
        Navigator.pushReplacementNamed(context, AppConstants.routeLanding);
      }

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
                child: Align(alignment: Alignment.bottomCenter, child: ScanItLogoImage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
