import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/my_custom_widget.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
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
                    labelText: "Password",
                    hintText: "Enter Password"),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomElevatedButton(
              buttonText: "LOGIN",
              onPressed: () {
                Fluttertoast.showToast(msg: "LOGIN");
              },
              buttonBgColor: Colors.grey),
        ],
      ),
    ));
  }
}
