import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
import '../../../domain/repository/providers/mro_repository_provider.dart';
import '../../../widgets/my_custom_widget.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// https://ppantaleon.medium.com/flutter-blocbuilder-vs-blocconsumer-vs-bloclistener-a4a3ce7bfa9a
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LogInCubit logInCubit = context.read<LogInCubit>();
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    print("TAG_PREF_LOGIN ${pref?.getBool(AppConstants.prefKeyIsLoggedIn)}");
    return Scaffold(
        body: Center(
      child: BlocConsumer<LogInCubit, LogInState>(
        listenWhen: (context, state) {
          return state is LogInSuccessState ||
              state is LogInFailureState ||
              state is LoadingState;
        },
        listener: (context, state) {
          if (state is LogInSuccessState) {
            // Must Hide Loading before success action performed
            hideLoading(_dialogKey);
            Navigator.pushNamed(context, AppConstants.routePassword);
          } else if (state is LogInFailureState) {
            // Must Hide Loading before failure action performed
            hideLoading(_dialogKey);
            displayDialog(context, state.userNameErrorMessage);
          } else if (state is LoadingState) {
            showLoading(context, _dialogKey);
          }
        },
        buildWhen: (context, state) {
          return state is LogInInitialState;
        },
        builder: (context, state) {
          if (state is LogInInitialState) {
            // Getting Access of Mro Repository singleton instance
            final mroRepository =
                MroRepositoryProvider.of(context)?.mroRepository;

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
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: StringConstants.hintEnterUserName,
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomElevatedButton(
                      buttonText: StringConstants.next.toUpperCase(),
                      onPressed: () {
                        if (mroRepository != null) {
                          logInCubit.submitForm(
                              userNameController.text, mroRepository, pref!);
                        }
                      },
                      buttonBgColor: ColorConstants.blueThemeColor),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: CustomElevatedButton(
                        buttonText: StringConstants.passwordReset.toUpperCase(),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppConstants.routePasswordReset);
                        },
                        buttonBgColor: Colors.red),
                  ),
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

  void displayDialog(BuildContext context, String message) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: message,
      onOkButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
