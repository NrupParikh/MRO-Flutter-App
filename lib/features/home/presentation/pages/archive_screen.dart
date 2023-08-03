import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/config/string_constants.dart';

import '../../../../config/color_constants.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.archive,
              style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
          actions: [
            TextButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: StringConstants.modify);
                },
                child: Text(
                  StringConstants.modify.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                )),
          ],
        ),
        body: const Center(child: Text("Archive")));
  }
}
