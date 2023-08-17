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
              Fluttertoast.showToast(msg: "${tabs[tabController.index].text} is selected");
            }
          });
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(StringConstants.archive, style: TextStyle(color: Colors.white)),
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
            body: Container(
              color: ColorConstants.gray200,
              child: TabBarView(
                children: tabs.map((Tab tab) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Fluttertoast.showToast(msg: "You click item at $index");
                            },
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  // ======= 1st and 2nd Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Row(children: [
                                            Text(
                                              "2023-08-03",
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              "USD 5346.00",
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14),
                                            )
                                          ]),
                                          Text("TEST2",
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14)),
                                        ]),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Fluttertoast.showToast(msg: "See attachment at $index");
                                        },
                                        child: const Icon(
                                          Icons.attach_file,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  // ========== Third Line
                                  Column(
                                    children: [
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        const Row(children: [
                                          Text("Status:",
                                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14)),
                                          Text("Waiting for approval",
                                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14))
                                        ]),
                                        InkWell(
                                          onTap: () {
                                            Fluttertoast.showToast(msg: "See visibility at $index");
                                          },
                                          child: const Icon(
                                            Icons.visibility,
                                            color: Colors.black,
                                          ),
                                        )
                                      ]),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
