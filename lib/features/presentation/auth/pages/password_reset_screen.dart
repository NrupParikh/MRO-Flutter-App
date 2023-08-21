import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
import '../../../domain/repository/providers/mro_repository_provider.dart';
import '../../../widgets/my_custom_widget.dart';
import '../bloc/password_reset/password_reset_cubit.dart';
import '../bloc/password_reset/password_reset_state.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PasswordResetCubit passwordResetCubit = context.read<PasswordResetCubit>();
    // Getting Access of Mro Repository singleton instance
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    Connectivity connectivity = Connectivity();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.passwordReset, style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
        body: Center(
          child: BlocConsumer<PasswordResetCubit, PasswordResetState>(
            listenWhen: (context, state) {
              return state is PasswordResetSuccessState ||
                  state is PasswordResetFinalSuccessState ||
                  state is PasswordResetFailureState ||
                  state is LoadingState;
            },
            listener: (context, state) {
              if (state is PasswordResetSuccessState) {
                hideLoading(_dialogKey);

                final mroRepository = MroRepositoryProvider.of(context)?.mroRepository;

                var tenantList = state.userTenantList;
                if (tenantList.length > 1) {
                  Navigator.pushNamed(context, AppConstants.routePasswordResetSchemaSelection,
                      arguments: {AppConstants.keyArgUserName: userNameController.text});
                } else {
                  passwordResetCubit.callResetPasswordAPI(userNameController.text, tenantList.first.id.toString(), mroRepository!);
                }
              } else if (state is PasswordResetFinalSuccessState) {
                hideLoading(_dialogKey);
                displayDialog(context, StringConstants.msgPasswordResetSuccess, true);
              } else if (state is PasswordResetFailureState) {
                hideLoading(_dialogKey);
                displayDialog(context, state.passwordResetErrorMessage, false);
              } else if (state is LoadingState) {
                showLoading(context, _dialogKey);
              }
            },
            buildWhen: (context, state) {
              return state is PasswordResetInitialState;
            },
            builder: (context, state) {
              if (state is PasswordResetInitialState) {
                final mroRepository = MroRepositoryProvider.of(context)?.mroRepository;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 48,
                      ),
                      const ScanItLogoImage(),
                      const SizedBox(
                        height: 48,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            StringConstants.userName,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: userNameController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            hintText: StringConstants.hintEnterUserName,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomElevatedButton(
                          buttonText: StringConstants.next.toUpperCase(),
                          onPressed: () async {
                            await connectivity.checkConnectivity().then((value) {
                              if (value == ConnectivityResult.none) {
                                passwordResetCubit.submitForm(userNameController.text, mroRepository!, pref!, false);
                              } else {
                                passwordResetCubit.submitForm(userNameController.text, mroRepository!, pref!, true);
                              }
                            });
                          },
                          buttonBgColor: ColorConstants.blueThemeColor)
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ));
  }

  // ================ SHOW OK DIALOG
  // https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  void displayDialog(BuildContext context, String message, bool isSuccess) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: message,
      onOkButtonPressed: () {
        if (isSuccess) {
          Navigator.popUntil(context, ModalRoute.withName(AppConstants.routeLogin));
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      onCancelButtonPressed: () {},
      hasCancelButton: false,
    );

    showDialog(context: context, builder: (BuildContext context) => dialog, barrierDismissible: false);
  }
}
