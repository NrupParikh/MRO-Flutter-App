import 'package:flutter/material.dart';
import 'package:mro/config/string_constants.dart';

import '../../../../config/color_constants.dart';

class MyApprovalsScreen extends StatefulWidget {
  const MyApprovalsScreen({super.key});

  @override
  State<MyApprovalsScreen> createState() => _MyApprovalsScreenState();
}

class _MyApprovalsScreenState extends State<MyApprovalsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.myApproval,
              style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
        body: const Center(child: Text("My Approvals")));
  }
}
