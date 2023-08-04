import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.appFullName,
              style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
          actions: [
            IconButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: StringConstants.syncMessage);
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.routeNewExpenses);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.homeScreenButtonBgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ic_new_expense.png",
                    height: 48.0,
                    width: 48.0,
                    color: ColorConstants.blueThemeColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    StringConstants.newExpense,
                    style: TextStyle(color: ColorConstants.blueThemeColor),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.routeArchive);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.homeScreenButtonBgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ic_archive.png",
                    width: 48,
                    height: 48,
                    color: ColorConstants.blueThemeColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    StringConstants.archive,
                    style: TextStyle(color: ColorConstants.blueThemeColor),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.routeMyApprovals);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.homeScreenButtonBgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ic_my_approvals.png",
                    width: 48,
                    height: 48,
                    color: ColorConstants.blueThemeColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    StringConstants.myApproval,
                    style: TextStyle(color: ColorConstants.blueThemeColor),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.routeSettings);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.homeScreenButtonBgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ic_settings.png",
                    width: 48,
                    height: 48,
                    color: ColorConstants.blueThemeColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    StringConstants.settings,
                    style: TextStyle(color: ColorConstants.blueThemeColor),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
