import 'package:flutter/material.dart';
import 'package:mro/config/constants/app_constants.dart';

import '../../config/constants/string_constants.dart';

// ================ COMMON BUTTON WITH FULL WIDTH
class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonBgColor;
  final double leftPadding;
  final double rightPadding;

  const CustomElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.buttonBgColor,
      required this.leftPadding,
      required this.rightPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonBgColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
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
    return Image.asset("assets/images/img_scan_it_logo.png", width: 200, height: 100);
  }
}

// ================ ALERT DIALOG WITH OK BUTTON

class MyCustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onOkButtonPressed;
  final VoidCallback onCancelButtonPressed;
  final bool hasCancelButton;

  const MyCustomAlertDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onOkButtonPressed,
      required this.onCancelButtonPressed,
      required this.hasCancelButton});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        if (hasCancelButton) ...[
          TextButton(onPressed: onCancelButtonPressed, child: const Text(AppConstants.cancel)),
        ],
        TextButton(onPressed: onOkButtonPressed, child: const Text(AppConstants.ok))
      ],
    );
  }
}

// =============== SHOW AND HIDE LOADING

void showLoading(BuildContext context, GlobalKey<State<StatefulWidget>> dialogKey) {
  showDialog(
    context: context,
    barrierDismissible: false,
    // Prevent the user from dismissing the dialog with a tap outside
    builder: (BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;

      return AlertDialog(
        key: dialogKey,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Center(
            child: SizedBox(width: screenWidth, height: screenHeight, child: const Center(child: CircularProgressIndicator()))),
      );
    },
  );
}

void hideLoading(GlobalKey<State<StatefulWidget>> dialogKey) {
  if (dialogKey.currentContext != null) {
    Navigator.of(dialogKey.currentContext!).pop();
  }
}

// ========= No Internet Snack Bar
void noInternetMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(StringConstants.mgsNoInternet),
      duration: Duration(seconds: 2),
    ),
  );
}

// ========= Choose Option Dialog

class ChooseOptionDialog extends StatelessWidget {
  final VoidCallback takeAPhoto;
  final VoidCallback chooseFromGallery;
  final VoidCallback chooseDocument;
  final VoidCallback onCancelButtonPressed;

  const ChooseOptionDialog(
      {super.key,
      required this.takeAPhoto,
      required this.chooseFromGallery,
      required this.chooseDocument,
      required this.onCancelButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        StringConstants.chooseOption,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: takeAPhoto,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                StringConstants.optionTakeAPhoto,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              )),
          TextButton(
              onPressed: chooseFromGallery,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                StringConstants.optionChooseFromGallery,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              )),
          TextButton(
              onPressed: chooseDocument,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                StringConstants.optionChooseDocument,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              )),
          TextButton(
              onPressed: onCancelButtonPressed,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                StringConstants.optionCancel,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              )),
        ],
      ),
    );
  }
}
