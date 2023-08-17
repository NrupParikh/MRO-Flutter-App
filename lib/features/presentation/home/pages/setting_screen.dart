import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
import '../../../widgets/my_custom_widget.dart';
import 'package:mro/config/shared_preferences/singleton/mro_shared_preference.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isBioMetric = false;

  @override
  Widget build(BuildContext context) {
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    print("TAG_PREF_SETTINGS ${pref?.getBool(AppConstants.prefKeyIsLoggedIn)}");
    isBioMetric = pref!.getBool(AppConstants.prefKeyIsBiometricEnabled);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.settings, style: TextStyle(color: Colors.white)),
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
                        pref.setBool(AppConstants.prefKeyIsBiometricEnabled, isBioMetric);
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
                          displayDialog(pref, context);
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
            const Padding(padding: EdgeInsets.only(bottom: 8), child: Text("Version: 1.0.0"))
          ],
        ));
  }

  // ====================== LOGOUT
  void performLogout(MroSharedPreference pref, BuildContext context) {
    var isBiometricEnabled = pref.getBool(AppConstants.prefKeyIsBiometricEnabled);

    if (isBiometricEnabled == true) {
      var userName = pref.getString(AppConstants.prefKeyUserNameWithSchemaId);
      var password = pref.getString(AppConstants.prefKeyPassword);
      pref.clear();
      pref.setString(AppConstants.prefKeyUserNameWithSchemaId, userName);
      pref.setString(AppConstants.prefKeyPassword, password);
      pref.setBool(AppConstants.prefKeyIsBiometricEnabled, true);
      Navigator.pushNamedAndRemoveUntil(context, AppConstants.routeLanding, (route) => false);
    } else {
      pref.clear();
      pref.setBool(AppConstants.prefKeyIsBiometricEnabled, false);
      Navigator.pushNamedAndRemoveUntil(context, AppConstants.routeLogin, (route) => false);
    }
    // Logout and navigate back to Landing Screen
  }

  // ================ SHOW OK DIALOG
  // https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  void displayDialog(MroSharedPreference pref, BuildContext context) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: StringConstants.msgLogoutConfirmation,
      onOkButtonPressed: () {
        performLogout(pref, context);
      },
      onCancelButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      hasCancelButton: true,
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
