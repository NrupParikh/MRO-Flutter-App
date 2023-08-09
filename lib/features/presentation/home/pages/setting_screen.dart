import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
import '../../../widgets/my_custom_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isBioMetric = true;

  @override
  Widget build(BuildContext context) {
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    print("TAG_PREF_SETTINGS ${pref?.getBool(AppConstants.prefKeyIsLoggedIn)}");

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.settings,
              style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(children: [
                Text(StringConstants.biometricAuthentication.toUpperCase()),
                const Spacer(
                  flex: 1,
                ),
                Switch(
                    value: isBioMetric,
                    onChanged: (bool value) {
                      setState(() {
                        isBioMetric = value;
                      });
                    })
              ]),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {
                          // Clear preference data and set user login to false
                          pref?.setBool(AppConstants.prefKeyIsLoggedIn, false);
                          pref?.clear();

                          // Logout and navigate back to Landing Screen
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppConstants.routeLanding, (route) => false);
                        },
                        child: Text(StringConstants.logout.toUpperCase())))),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            const Spacer(
              flex: 1,
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text("Version: 1.0.0"))
          ],
        ));
  }

  // ================ SHOW OK DIALOG
  // https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  void displayDialog(BuildContext context) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: StringConstants.msgPasswordResetSuccess,
      onOkButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
