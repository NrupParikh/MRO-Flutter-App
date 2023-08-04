import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mro/features/auth/presentation/bloc/login_cubit.dart';
import 'package:mro/features/auth/presentation/bloc/login_state.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../widgets/my_custom_widget.dart';

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
            Fluttertoast.showToast(msg: state.userNameErrorMessage);
          }
        },
        buildWhen: (context, state) {
          return state is LogInInitialState;
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
              const Spacer(
                flex: 1,
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
          );
        },
      ),
    ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   final LogInCubit logInCubit = context.read<LogInCubit>();
  //
  //   return Scaffold(body: Center(
  //     child: BlocBuilder<LogInCubit, LogInState>(
  //       builder: (context, state) {
  //         if (state is LogInFailureState) {
  //           return Center(
  //             child: Text(state.userNameErrorMessage),
  //           );
  //         } else if (state is LoginSuccessState) {
  //           return const Center(
  //             child: Text(
  //               'Form submitted successfully!',
  //               style: TextStyle(fontSize: 20.0),
  //             ),
  //           );
  //         } else {
  //           return Column(
  //             children: [
  //               const SizedBox(
  //                 height: 50,
  //               ),
  //               const ScanItLogoImage(),
  //               const SizedBox(
  //                 height: 50,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 32, right: 32),
  //                 child: SizedBox(
  //                   width: double.infinity,
  //                   child: TextField(
  //                     controller: userNameController,
  //                     decoration: const InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: StringConstants.userName,
  //                         hintText: StringConstants.hintEnterUserName),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 16,
  //               ),
  //               CustomElevatedButton(
  //                   buttonText: StringConstants.next.toUpperCase(),
  //                   onPressed: () =>
  //                       logInCubit.submitForm(userNameController.text),
  //                   buttonBgColor: ColorConstants.blueThemeColor),
  //               const Spacer(
  //                 flex: 1,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(bottom: 32),
  //                 child: CustomElevatedButton(
  //                     buttonText: StringConstants.passwordReset.toUpperCase(),
  //                     onPressed: () {
  //                       Navigator.pushNamed(
  //                           context, AppConstants.routePasswordReset);
  //                     },
  //                     buttonBgColor: Colors.red),
  //               ),
  //             ],
  //           );
  //         }
  //       },
  //     ),
  //   ));
  // }

  void displayDialog(BuildContext context) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: StringConstants.msgPasswordResetSuccess,
      onOkButtonPressed: () {},
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
