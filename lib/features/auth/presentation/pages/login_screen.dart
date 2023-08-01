import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/features/auth/presentation/pages/password_reset_screen.dart';
import 'package:mro/features/auth/presentation/pages/password_screen.dart';

import '../../../../config/color_constants.dart';
import '../widgets/my_custom_widget.dart';

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
                    labelText: "User Name",
                    hintText: "Enter User Name"),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomElevatedButton(
              buttonText: "NEXT",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordScreen()));
              },
              buttonBgColor: ColorConstants.blueThemeColor),
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CustomElevatedButton(
                buttonText: "PASSWORD RESET",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordResetScreen()));
                },
                buttonBgColor: Colors.red),
          ),
        ],
      ),
    ));
  }
}
