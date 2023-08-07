import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mro/config/constants/app_constants.dart';

import '../../../../config/constants/string_constants.dart';
import '../../../widgets/my_custom_widget.dart';
import '../bloc/password/password_cubit.dart';
import '../bloc/password/password_state.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PasswordCubit passwordCubit = context.read<PasswordCubit>();
    return Scaffold(
        body: Center(
      child: BlocConsumer<PasswordCubit, PasswordState>(
        listenWhen: (context, state) {
          return state is PasswordSuccessState || state is PasswordFailureState;
        },
        listener: (context, state) {
          if (state is PasswordSuccessState) {
            // Remove Auth Flow from Stack and Move to Home
            Navigator.pushNamedAndRemoveUntil(
                context, AppConstants.routeHome, (route) => false);
          } else if (state is PasswordFailureState) {
            displayDialog(context, state.passwordErrorMessage);
          }
        },
        buildWhen: (context, state) {
          return state is PasswordInitialState;
        },
        builder: (context, state) {
          return Column(
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
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: StringConstants.password,
                        hintText: StringConstants.hintEnterPassword),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomElevatedButton(
                  buttonText: StringConstants.login.toUpperCase(),
                  onPressed: () =>
                      passwordCubit.submitForm(passwordController.text),
                  buttonBgColor: Colors.grey),
            ],
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
