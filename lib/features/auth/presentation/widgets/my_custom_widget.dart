import 'package:flutter/material.dart';

// ================ COMMON BUTTON WITH FULL WIDTH
class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonBgColor;

  const CustomElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.buttonBgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonBgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0))),
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// =================== APP LOGO IMAGE
class ScanItLogoImage extends StatelessWidget {
  const ScanItLogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/img_scan_it_logo.png",
        width: 200, height: 100);
  }
}

// ================ ALERT DIALOG WITH OK BUTTON

class MyCustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onOkButtonPressed;

  const MyCustomAlertDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onOkButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(onPressed: onOkButtonPressed, child: const Text("OK"))
      ],
    );
  }
}