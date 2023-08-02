import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mro/config/app_constants.dart';
import 'package:mro/features/auth/presentation/pages/landing_screen.dart';
import 'package:mro/features/auth/presentation/pages/login_screen.dart';
import 'package:mro/features/auth/presentation/pages/password_reset_screen.dart';
import 'package:mro/features/auth/presentation/pages/password_screen.dart';
import 'package:mro/features/auth/presentation/pages/splash_screen.dart';
import 'package:mro/features/home/presentation/pages/home_screen.dart';

import 'features/home/presentation/pages/setting_screen.dart';

void main() {
  // Application works only in Portrait Mode by below mentioned code
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MRO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppConstants.routeSplash,
      routes: {
        AppConstants.routeSplash: (context) => const SplashScreen(),
        AppConstants.routeLanding: (context) => const LandingScreen(),
        AppConstants.routeLogin: (context) => const LoginScreen(),
        AppConstants.routePassword: (context) => const PasswordScreen(),
        AppConstants.routePasswordReset: (context) =>
            const PasswordResetScreen(),
        AppConstants.routeHome: (context) => const HomeScreen(),
        AppConstants.routeSettings: (context) => const SettingsScreen(),
      },
    );
  }
}
