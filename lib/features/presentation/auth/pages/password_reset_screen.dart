import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../widgets/my_custom_widget.dart';
import '../bloc/password_reset/password_reset_cubit.dart';
import '../bloc/password_reset/password_reset_state.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PasswordResetCubit passwordResetCubit =
        context.read<PasswordResetCubit>();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.passwordReset,
              style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
        body: Center(
          child: BlocConsumer<PasswordResetCubit, PasswordResetState>(
            listenWhen: (context, state) {
              return state is PasswordResetSuccessState ||
                  state is PasswordResetFailureState;
            },
            listener: (context, state) {
              if (state is PasswordResetSuccessState) {
                displayDialog(
                    context, StringConstants.msgPasswordResetSuccess, true);
              } else if (state is PasswordResetFailureState) {
                displayDialog(context, state.passwordResetErrorMessage, false);
              }
            },
            buildWhen: (context, state) {
              return state is PasswordResetInitialState;
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
                        onPressed: () => passwordResetCubit
                            .submitForm(userNameController.text),
                        buttonBgColor: ColorConstants.blueThemeColor)
                  ],
                ),
              );
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
          // Dismiss dialog and go back screen
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pop();
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
