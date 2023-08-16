import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
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
          localizedReason: "Please authenticate", options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true));
      if (didAuthenticate == true) {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, AppConstants.routeHome, (route) => false);
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
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    var isBiometricEnabled = pref?.getBool(AppConstants.prefKeyIsBiometricEnabled);

    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                ),
                ScanItLogoImage(),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomElevatedButton(
                buttonText: StringConstants.loginWithCredentials.toUpperCase(),
                onPressed: () {
                  Navigator.pushNamed(context, AppConstants.routeLogin);
                },
                buttonBgColor: ColorConstants.blueThemeColor,
              ),
              if (isBiometricEnabled == true) ...[
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
              ]
            ],
          ),
        ],
      )),
    );
  }
}
