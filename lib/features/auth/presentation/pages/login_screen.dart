import 'package:flutter/material.dart';
import 'package:mro/config/string_constants.dart';

import '../../../../config/app_constants.dart';
import '../../../../config/color_constants.dart';
import '../../../widgets/my_custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: StringConstants.userName,
                    hintText: StringConstants.hintEnterUserName),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomElevatedButton(
              buttonText: "NEXT",
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.routePassword);
              },
              buttonBgColor: ColorConstants.blueThemeColor),
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CustomElevatedButton(
                buttonText: StringConstants.passwordReset.toUpperCase(),
                onPressed: () {
                  Navigator.pushNamed(context, AppConstants.routePasswordReset);
                },
                buttonBgColor: Colors.red),
          ),
        ],
      ),
    ));
  }
}
