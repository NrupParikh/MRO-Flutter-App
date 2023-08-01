import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/config/color_constants.dart';
import 'package:mro/features/auth/presentation/pages/login_screen.dart';

import '../widgets/my_custom_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const ScanItLogoImage(),
            const SizedBox(
              height: 50,
            ),
            CustomElevatedButton(
              buttonText: "LOGIN WITH CREDENTIALS",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              buttonBgColor: ColorConstants.blueThemeColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Or"),
            const SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
                buttonText: "LOGIN WITH BIOMETRIC",
                onPressed: () {
                  Fluttertoast.showToast(msg: "Login with Biometric");
                },
                buttonBgColor: ColorConstants.blueThemeColor)
          ],
        ),
      ),
    );
  }
}
