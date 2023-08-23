import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/features/presentation/home/bloc/get_currency/get_currency_cubit.dart';
import 'package:mro/features/presentation/home/bloc/get_currency/get_currency_state.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
import '../../../data/data_sources/local/database/provider/mro_database_provider.dart';
import '../../../domain/repository/providers/mro_repository_provider.dart';
import '../../../widgets/my_custom_widget.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    final GetCurrencyCubit getCurrencyCubit = context.read<GetCurrencyCubit>();
    Connectivity connectivity = Connectivity();
    final database = MroDatabaseProvider.of(context).database;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.appFullName, style: TextStyle(color: Colors.white)),
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
        body: BlocConsumer<GetCurrencyCubit, GetCurrencyState>(
          listenWhen: (context, state) {
            return state is GetCurrencySuccessState || state is GetCurrencyFailureState || state is LoadingState;
          },
          listener: (context, state) {
            if (state is GetCurrencySuccessState) {
              hideLoading(_dialogKey);
            } else if (state is GetCurrencyFailureState) {
              hideLoading(_dialogKey);
              displayDialog(context, state.getCurrencyFailureMessage);
            } else if (state is LoadingState) {
              showLoading(context, _dialogKey);
            }
          },
          buildWhen: (context, state) {
            return state is GetCurrencyInitialState;
          },
          builder: (context, state) {
            if (state is GetCurrencyInitialState) {
              final mroRepository = MroRepositoryProvider.of(context)?.mroRepository;

              connectivity.checkConnectivity().then((value) {
                if (value == ConnectivityResult.none) {
                  getCurrencyCubit.getCurrency(database,mroRepository!, pref!, false);
                } else {
                  getCurrencyCubit.getCurrency(database,mroRepository!, pref!, true);
                }
              });

              return const HomeScreenUI();
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ));
  }

  void displayDialog(BuildContext context, String message) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: message,
      onOkButtonPressed: () {},
      onCancelButtonPressed: () {},
      hasCancelButton: false,
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}

class HomeScreenUI extends StatelessWidget {
  const HomeScreenUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
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
    );
  }
}
