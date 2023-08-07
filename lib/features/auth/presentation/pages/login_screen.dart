import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mro/features/auth/presentation/bloc/login/login_cubit.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../widgets/my_custom_widget.dart';
import '../bloc/login/login_state.dart';

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

    return Scaffold(
        body: Center(
      child: BlocConsumer<LogInCubit, LogInState>(
        listenWhen: (context, state) {
          return state is LoginSuccessState || state is LogInFailureState;
        },
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamed(context, AppConstants.routePassword);
          } else if (state is LogInFailureState) {
            displayDialog(context, state.userNameErrorMessage);
          }
        },
        buildWhen: (context, state) {
          return state is LogInInitialState;
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const ScanItLogoImage(),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: StringConstants.userName,
                          hintText: StringConstants.hintEnterUserName),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                    buttonText: StringConstants.next.toUpperCase(),
                    onPressed: () =>
                        logInCubit.submitForm(userNameController.text),
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
