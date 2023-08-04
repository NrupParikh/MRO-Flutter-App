import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

// =========== TAB
// https://tinyurl.com/TabBarController
List<Tab> tabs = <Tab>[
  Tab(text: StringConstants.tabDraft.toUpperCase()),
  Tab(text: StringConstants.tabPendingUpload.toUpperCase()),
  Tab(text: StringConstants.tabPendingApproval.toUpperCase()),
  Tab(text: StringConstants.tabApproved.toUpperCase()),
];

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              Fluttertoast.showToast(
                  msg: "${tabs[tabController.index].text} is selected");
            }
          });
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
              bottom: TabBar(
                tabs: tabs,
                isScrollable: true,
                unselectedLabelColor: Colors.white30,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
              ),
            ),
            body: TabBarView(
              children: tabs.map((Tab tab) {
                return Center(
                  child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Item $index"),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
