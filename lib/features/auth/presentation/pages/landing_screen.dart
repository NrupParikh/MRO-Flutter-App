import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
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
  late final LocalAuthentication auth;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
  }

  // // ================== BIOMETRIC AUTHENTICATION

  Future<void> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: "Please authenticate",
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));
      if (didAuthenticate == true) {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
            context, AppConstants.routeHome, (route) => false);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        Fluttertoast.showToast(msg: StringConstants.localizedReason);
      } else if (e.code == auth_error.lockedOut) {
        Fluttertoast.showToast(msg: StringConstants.lockedOut);
      } else if (e.code == auth_error.biometricOnlyNotSupported) {
        Fluttertoast.showToast(msg: StringConstants.biometricOnlyNotSupported);
      } else if (e.code == auth_error.notAvailable) {
        Fluttertoast.showToast(msg: StringConstants.notAvailable);
      } else if (e.code == auth_error.otherOperatingSystem) {
        Fluttertoast.showToast(msg: StringConstants.otherOperatingSystem);
      } else if (e.code == auth_error.passcodeNotSet) {
        Fluttertoast.showToast(msg: StringConstants.passcodeNotSet);
      } else if (e.code == auth_error.permanentlyLockedOut) {
        Fluttertoast.showToast(msg: StringConstants.permanentlyLockedOut);
      }
    }
  }

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
                  authenticate();
                },
                buttonBgColor: ColorConstants.blueThemeColor)
          ],
        ),
      ),
    );
  }
}
