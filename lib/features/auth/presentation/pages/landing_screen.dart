import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/config/color_constants.dart';
import 'package:mro/config/string_constants.dart';

import '../../../../config/app_constants.dart';
import '../../../widgets/my_custom_widget.dart';

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
              buttonText: StringConstants.loginWithCredentials.toUpperCase(),
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.routeLogin);
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
                buttonText: StringConstants.loginWithBioMetric.toUpperCase(),
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
