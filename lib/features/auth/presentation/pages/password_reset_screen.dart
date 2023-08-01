import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/config/constants.dart';
import 'package:mro/features/auth/presentation/pages/password_screen.dart';

import '../../../../config/color_constants.dart';
import '../widgets/my_custom_widget.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Password Reset",
              style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
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
                    displayDialog(context);
                  },
                  buttonBgColor: ColorConstants.blueThemeColor)
            ],
          ),
        ));
  }

  // ================ SHOW OK DIALOG
  // https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  void displayDialog(BuildContext context) {
    var dialog = MyCustomAlertDialog(
      title: Constants.appFullName,
      description: Constants.msgPasswordResetSuccess,
      onOkButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
