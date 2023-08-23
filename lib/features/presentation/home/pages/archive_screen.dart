import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/config/shared_preferences/provider/mro_shared_preference_provider.dart';
import 'package:mro/features/data/data_sources/local/database/provider/mro_database_provider.dart';
import 'package:mro/features/data/models/get_expense_list/expense_list.dart';
import 'package:mro/features/domain/repository/providers/mro_repository_provider.dart';
import 'package:mro/features/presentation/home/bloc/get_expense_list/GetExpenseListCubit.dart';
import 'package:mro/features/presentation/home/bloc/get_expense_list/get_expense_list_state.dart';
import 'package:mro/features/widgets/my_custom_widget.dart';

import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

// =========== TAB
List<Tab> tabs = <Tab>[
  Tab(text: StringConstants.tabDraft.toUpperCase()),
  Tab(text: StringConstants.tabPendingUpload.toUpperCase()),
  Tab(text: StringConstants.tabPendingApproval.toUpperCase()),
  Tab(text: StringConstants.tabApproved.toUpperCase()),
];

class _ArchiveScreenState extends State<ArchiveScreen> implements TickerProvider {
  late TabController _tabController;
  bool _showMenu = true;

  // GetExpenseList getExpenseList = GetExpenseList(count: 0, list: List<ExpenseList>.empty());
  List<ExpenseList> getExpenseList = List<ExpenseList>.empty();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _showMenu = _tabController.index == 0 || _tabController.index == 1 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    final GetExpenseListCubit getExpenseListCubit = context.read<GetExpenseListCubit>();
    Connectivity connectivity = Connectivity();
    final database = MroDatabaseProvider.of(context).database;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(StringConstants.archive, style: TextStyle(color: Colors.white)),
        backgroundColor: ColorConstants.blueThemeColor,
        actions: [
          Visibility(
            visible: _showMenu,
            child: TextButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: StringConstants.modify);
                },
                child: Text(
                  StringConstants.modify.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                )),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
          isScrollable: true,
          unselectedLabelColor: Colors.white30,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
      ),
      body: BlocConsumer<GetExpenseListCubit, GetExpenseListState>(
        listenWhen: (context, state) {
          return state is GetExpenseListFailureState || state is LoadingState;
        },
        listener: (context, state) {
          if (state is GetExpenseListFailureState) {
            hideLoading(_dialogKey);
            displayDialog(context, state.getExpenseListFailureMessage);
          } else if (state is LoadingState) {
            showLoading(context, _dialogKey);
          }
        },
        buildWhen: (context, state) {
          return state is GetExpenseListInitialState || state is GetExpenseListSuccessState;
        },
        builder: (context, state) {
          if (state is GetExpenseListInitialState) {
            final mroRepository = MroRepositoryProvider.of(context)?.mroRepository;
            connectivity.checkConnectivity().then((value) {
              if (value == ConnectivityResult.none) {
                getExpenseListCubit.getExpenseList(database, mroRepository!, pref!, false);
              } else {
                getExpenseListCubit.getExpenseList(database, mroRepository!, pref!, true);
              }
            });
            return ArchiveScreenUI(tabController: _tabController, getExpenseList: getExpenseList);
          } else if (state is GetExpenseListSuccessState) {
            hideLoading(_dialogKey);
            getExpenseList = state.getExpenseList.list!;
            print("TAG_COUNTER ${getExpenseList.length.toString()}");
            return ArchiveScreenUI(tabController: _tabController, getExpenseList: getExpenseList);
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);

  void displayDialog(BuildContext context, String message) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: message,
      onOkButtonPressed: () {
        Navigator.of(context).pop();
      },
      onCancelButtonPressed: () {},
      hasCancelButton: false,
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}

class ArchiveScreenUI extends StatelessWidget {
  const ArchiveScreenUI({
    super.key,
    required TabController tabController,
    required this.getExpenseList,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<ExpenseList> getExpenseList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.gray200,
      child: TabBarView(
        controller: _tabController,
        children: tabs.map((Tab tab) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: getExpenseList.isNotEmpty
                  ? ListView.builder(
                      itemCount: getExpenseList.length,
                      itemBuilder: (context, index) {
                        var data = getExpenseList[index];
                        var created = data.created;
                        String? year = created?[0].toString();
                        String? month = created?[1].toString();
                        String? date = created?[2].toString();

                        String fullDate = '${year!}-${month!}-${date!}';
                        String? iso = data.amount?.currency?.iso;
                        String amount = (data.amount?.amount).toString();

                        String cost = "$iso $amount";
                        String? name = data.account?.name;
                        String? status = data.currentState?.name;

                        bool hasAttachment = data.attachments!.isNotEmpty ? true : false;

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
                                    Expanded(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Row(children: [
                                          Text(
                                            fullDate,
                                            style:
                                                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            cost,
                                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14),
                                          )
                                        ]),
                                        Text(name!,
                                            style:
                                                const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14)),
                                      ]),
                                    ),
                                    Visibility(
                                      visible: hasAttachment,
                                      child: InkWell(
                                        onTap: () {
                                          Fluttertoast.showToast(msg: "See attachment at $index");
                                        },
                                        child: const Icon(
                                          Icons.attach_file,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // ========== Third Line
                                Column(
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Row(children: [
                                        const Text(StringConstants.expenseStatus,
                                            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14)),
                                        Text(status!,
                                            style:
                                                const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14))
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
                    )
                  : const Center(child: Text("No Data Found")),
            ),
          );
        }).toList(),
      ),
    );
  }
}
