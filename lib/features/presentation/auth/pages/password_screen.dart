import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/shared_preferences/provider/mro_shared_preference_provider.dart';

import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../data/models/user_schemas/user_schemas.dart';
import '../../../data/models/user_schemas/user_tenant_list.dart';
import '../../../domain/repository/providers/mro_repository_provider.dart';
import '../../../widgets/my_custom_widget.dart';
import '../bloc/password/password_cubit.dart';
import '../bloc/password/password_state.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();
List<UserTenantList> list = <UserTenantList>[];

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  late UserTenantList dropdownValue;
  bool isDropDownSelected = false;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    var userName = arguments[AppConstants.keyArgUserName];

    print("USER_NAME $userName");

    // Getting Access of Mro Repository singleton instance
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    print(
        "TAG_PREF_USER_SCHEMA ${pref?.getString(AppConstants.prefKeyUserSchema)}");

    final PasswordCubit passwordCubit = context.read<PasswordCubit>();

    Connectivity connectivity = Connectivity();
    return Scaffold(
        body: Center(
      child: BlocConsumer<PasswordCubit, PasswordState>(
        listenWhen: (context, state) {
          return state is PasswordSuccessState ||
              state is PasswordFailureState ||
              state is LoadingState;
        },
        listener: (context, state) {
          if (state is PasswordSuccessState) {
            pref?.setBool(AppConstants.prefKeyIsLoggedIn, true);
            hideLoading(_dialogKey);
            // Remove Auth Flow from Stack and Move to Home
            Navigator.pushNamedAndRemoveUntil(
                context, AppConstants.routeHome, (route) => false);
          } else if (state is PasswordFailureState) {
            hideLoading(_dialogKey);
            displayDialog(context, state.passwordErrorMessage);
          } else if (state is LoadingState) {
            showLoading(context, _dialogKey);
          }
        },
        buildWhen: (context, state) {
          return state is PasswordInitialState;
        },
        builder: (context, state) {
          if (state is PasswordInitialState) {
            final mroRepository =
                MroRepositoryProvider.of(context)?.mroRepository;
            /*
            * This flag check if item selected from DropDown then we don't re-call the pref values and
            re-set the dropdown value
            */
            if (isDropDownSelected == false) {
              var userSchema = pref?.getString(AppConstants.prefKeyUserSchema);
              if (userSchema != null) {
                Map<String, dynamic> decodedPerson = json.decode(userSchema);
                UserSchemas userSchemas = UserSchemas.fromJson(decodedPerson);
                if (userSchemas.success == true) {
                  List<UserTenantList>? userTenantList =
                      userSchemas.userTenantList;
                  list.clear();
                  for (int i = 0; i < userTenantList!.length; i++) {
                    print("TAG_Tenant_Schema ${userTenantList[i].schemaName}");
                    print("TAG_Tenant_Name ${userTenantList[i].name}");
                    list.add(userTenantList[i]);
                  }
                  dropdownValue = list.first;
                }
              }
            }

            // =========== DRAW UI
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
                        StringConstants.password,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: passwordController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: StringConstants.hintEnterPassword,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  if (list.length > 1) ...[
                    const SizedBox(
                      height: 24,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          StringConstants.selectSchema,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<UserTenantList>(
                            isExpanded: true,
                            // Full width
                            value: dropdownValue,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            items: list.map<DropdownMenuItem<UserTenantList>>(
                                (UserTenantList value) {
                              return DropdownMenuItem<UserTenantList>(
                                value: value,
                                child: Text(value.name.toString()),
                              );
                            }).toList(),
                            onChanged: (UserTenantList? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                isDropDownSelected = true;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                  const SizedBox(
                    height: 8,
                  ),
                  CustomElevatedButton(
                      buttonText: StringConstants.login.toUpperCase(),
                      onPressed: () async {
                        var schemaId = dropdownValue.id.toString();
                        await connectivity.checkConnectivity().then((value) {
                          if (value == ConnectivityResult.none) {
                            passwordCubit.submitForm(
                                userName,
                                passwordController.text,
                                schemaId,
                                mroRepository,
                                pref!,
                                false);
                          } else {
                            passwordCubit.submitForm(
                                userName,
                                passwordController.text,
                                schemaId,
                                mroRepository,
                                pref!,
                                true);
                          }
                        });
                      },
                      buttonBgColor: ColorConstants.blueThemeColor),
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
