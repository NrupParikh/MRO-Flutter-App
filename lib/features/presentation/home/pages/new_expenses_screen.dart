import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/presentation/home/bloc/new_expense/new_expense_cubit.dart';
import 'package:mro/features/presentation/home/bloc/new_expense/new_expense_state.dart';

import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../data/data_sources/local/database/mro_database.dart';
import '../../../data/models/currency/currency.dart';
import '../../../data/models/sign_in/organizations.dart';
import '../../../widgets/my_custom_widget.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();

class NewExpensesScreen extends StatefulWidget {
  const NewExpensesScreen({super.key});

  @override
  State<NewExpensesScreen> createState() => _NewExpensesScreenState();
}

class _NewExpensesScreenState extends State<NewExpensesScreen> {
  late List<OrganizationDropDown> organizationList;
  late List<CurrencyDropDown> currencyList;
  late List<AccountDropDown> accountList;

  late OrganizationDropDown drpOrganizationValue;
  late CurrencyDropDown drpCurrencyValue;
  late AccountDropDown drpAccountValue;

  late bool isOrganizationDropDownSelected;
  late bool isCurrencyDropDownSelected;
  late bool isAccountDropDownSelected;

  TextEditingController expenseDateController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController vat1Controller = TextEditingController();
  TextEditingController vat2Controller = TextEditingController();
  TextEditingController totalOfVAT1andVAT2 = TextEditingController();

  int radioGroupSelectedValue = 1;

  @override
  void initState() {
    super.initState();
    organizationList = <OrganizationDropDown>[];
    currencyList = <CurrencyDropDown>[];
    accountList = <AccountDropDown>[];

    isOrganizationDropDownSelected = false;
    isCurrencyDropDownSelected = false;
    isAccountDropDownSelected = false;
    debugPrint("TAG_initState");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("TAG_disposeState");
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.addExpense, style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
        body: BlocConsumer<NewExpenseCubit, NewExpenseState>(
          listenWhen: (context, state) {
            return state is NewExpenseSuccessState || state is NewExpenseFailureState || state is LoadingState;
          },
          listener: (context, state) {
            if (state is NewExpenseSuccessState) {
              hideLoading(_dialogKey);
            } else if (state is NewExpenseFailureState) {
              hideLoading(_dialogKey);
              displayDialog(context, state.newExpenseErrorMessage);
            } else if (state is LoadingState) {
              showLoading(context, _dialogKey);
            }
          },
          buildWhen: (context, state) {
            return state is NewExpenseInitialState;
          },
          builder: (context, state) {
            if (state is NewExpenseInitialState) {
              debugPrint("TAG_NewExpenseInitialState");

              // ================= ORGANIZATION DB LIST

              if (isOrganizationDropDownSelected == false) {
                if (state.organizations.isNotEmpty) {
                  List<Organizations> organizationsFuture = state.organizations;
                  organizationList.clear();
                  debugPrint("=========== ORGANIZATIONS=========== ");
                  for (int i = 0; i < organizationsFuture!.length; i++) {
                    var organizationData = organizationsFuture[i];
                    debugPrint("TAG_organization_$i : ${organizationsFuture[i].name}");
                    organizationList.add(OrganizationDropDown(organizationData.id, organizationData.name));
                  }
                  drpOrganizationValue = organizationList.first;
                }
              }

              // ================= CURRENCY DB LIST

              if (isCurrencyDropDownSelected == false) {
                if (state.currencies.isNotEmpty) {
                  List<Currency> currenciesFuture = state.currencies;
                  currencyList.clear();
                  debugPrint("=========== CURRENCY=========== ");
                  for (int i = 0; i < currenciesFuture.length; i++) {
                    var currencyData = currenciesFuture[i];
                    debugPrint("TAG_currency_$i : ${currenciesFuture[i].name}");
                    currencyList.add(CurrencyDropDown(currencyData.id, currencyData.name));
                  }
                  drpCurrencyValue = currencyList.first;
                }
              }

              // ================= Account DB LIST

              if (isAccountDropDownSelected == false) {
                if (state.accounts.isNotEmpty) {
                  List<Accounts> accountFuture = state.accounts;
                  accountList.clear();
                  debugPrint("=========== ACCOUNT =========== ");
                  var firstOrganizationId = drpOrganizationValue.id;
                  debugPrint("TAG_firstOrganizationId $firstOrganizationId");
                  for (int i = 0; i < accountFuture.length; i++) {
                    var accountData = accountFuture[i];
                    if (accountData.organizationId == firstOrganizationId) {
                      debugPrint("TAG_account_$i : ${accountFuture[i].name}");
                      accountList.add(AccountDropDown(accountData.id, accountData.name, accountData.organizationId));
                    }
                  }
                  drpAccountValue = accountList.first;
                }
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (organizationList.length > 1) ...[
                            const SizedBox(
                              height: 8,
                            ),

                            // =================== ORGANIZATION LABEL AND DROP DOWN

                            const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Row(children: [
                                Text(
                                  StringConstants.organization,
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                )
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<OrganizationDropDown>(
                                  isExpanded: true,
                                  // Full width
                                  value: drpOrganizationValue,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  items:
                                      organizationList.map<DropdownMenuItem<OrganizationDropDown>>((OrganizationDropDown value) {
                                    return DropdownMenuItem<OrganizationDropDown>(
                                      value: value,
                                      child: Text(value.name.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (OrganizationDropDown? value) {
                                    setState(() {
                                      drpOrganizationValue = value!;
                                      isOrganizationDropDownSelected = true;
                                      isAccountDropDownSelected = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // =================== EXPENSE DATE AND CAMERA IMAGE

                            Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Row(children: [
                                          Text(
                                            StringConstants.expenseDate,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "*",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ]),
                                      ),
                                      // Text("data")
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        child: TextField(
                                          style: const TextStyle(color: Colors.black),
                                          controller: expenseDateController,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            hintText: StringConstants.hintSelectExpenseDate,
                                            hintStyle: TextStyle(color: Colors.grey),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          showChooseOptionDialog(context);
                                        },
                                        child: Image.asset(
                                          "assets/images/ic_camera.png",
                                          width: 48,
                                          height: 48,
                                          color: ColorConstants.blueThemeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),

                            // =================== EXPENSE AMOUNT

                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Row(children: [
                                          Text(
                                            StringConstants.expenseAmount,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        child: TextField(
                                          style: const TextStyle(color: Colors.black),
                                          controller: expenseAmountController,
                                          enabled: false,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            hintText: "0.00",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<CurrencyDropDown>(
                                            isExpanded: true,
                                            // Full width
                                            value: drpCurrencyValue,
                                            style: const TextStyle(color: Colors.black),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                            items: currencyList.map<DropdownMenuItem<CurrencyDropDown>>((CurrencyDropDown value) {
                                              return DropdownMenuItem<CurrencyDropDown>(
                                                value: value,
                                                child: Text(value.name.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (CurrencyDropDown? value) {
                                              setState(() {
                                                drpCurrencyValue = value!;
                                                isCurrencyDropDownSelected = true;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),

                            // =================== VAT AMOUNT

                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Row(children: [
                                          Text(
                                            StringConstants.vat1Amount,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "*",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ]),
                                      ),
                                      // Text("data")
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        child: TextField(
                                          style: const TextStyle(color: Colors.black),
                                          controller: vat1Controller,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            hintText: StringConstants.hintEnterAmount,
                                            hintStyle: TextStyle(color: Colors.grey),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Row(children: [
                                          Text(
                                            StringConstants.vat2Amount,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "*",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ]),
                                      ),
                                      // Text("data")
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        child: TextField(
                                          style: const TextStyle(color: Colors.black),
                                          controller: vat2Controller,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            hintText: StringConstants.hintEnterAmount,
                                            hintStyle: TextStyle(color: Colors.grey),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),

                            // =================== TOTAL AMOUNT INCL.  VAT1 AND VAT2

                            const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Row(children: [
                                Text(
                                  StringConstants.totalOfVAT1andVAT2,
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                )
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                controller: totalOfVAT1andVAT2,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  hintText: StringConstants.hintEnterAmount,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            // =================== Company CC or Personal

                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                      title: const Text(
                                        StringConstants.radioButtonLblCreditCard,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      value: 1,
                                      visualDensity: const VisualDensity(horizontal: -4.0),
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      groupValue: radioGroupSelectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          radioGroupSelectedValue = value!;
                                        });
                                      }),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                      title: const Text(
                                        StringConstants.radioButtonLblPersonal,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      value: 2,
                                      visualDensity: const VisualDensity(horizontal: -4.0),
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      groupValue: radioGroupSelectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          radioGroupSelectedValue = value!;
                                        });
                                      }),
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 16,
                            ),
                            // =================== Account LABEL AND DROP DOWN

                            const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Row(children: [
                                Text(
                                  StringConstants.account,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<AccountDropDown>(
                                  isExpanded: true,
                                  // Full width
                                  value: drpAccountValue,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  items: accountList.map<DropdownMenuItem<AccountDropDown>>((AccountDropDown value) {
                                    return DropdownMenuItem<AccountDropDown>(
                                      value: value,
                                      child: Text(value.name.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (AccountDropDown? value) {
                                    setState(() {
                                      drpAccountValue = value!;
                                      isAccountDropDownSelected = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ],
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                      buttonText: StringConstants.save.toUpperCase(),
                      onPressed: () async {
                        await connectivity.checkConnectivity().then((value) {
                          if (value == ConnectivityResult.none) {
                            // ToDo NO
                          } else {
                            // ToDo YES
                          }
                        });
                      },
                      buttonBgColor: ColorConstants.blueThemeColor,
                      leftPadding: 8,
                      rightPadding: 8),
                ],
              );
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

  Future<List<Organizations>> fetchOrganizations(MroDatabase database, int employeeId) {
    final organizations = database.mroDao.getOrganizationsBasedOnEmployee(employeeId!);
    return organizations;
  }
}

class OrganizationDropDown {
  int? id;
  String? name;

  OrganizationDropDown(this.id, this.name);
}

class CurrencyDropDown {
  int? id;
  String? name;

  CurrencyDropDown(this.id, this.name);
}

class AccountDropDown {
  int? id;
  String? name;
  int? organizationId;

  AccountDropDown(this.id, this.name, this.organizationId);
}

// Choose Option Dialog

void showChooseOptionDialog(BuildContext context) {
  var dialog = ChooseOptionDialog(
    takeAPhoto: () {
      Fluttertoast.showToast(msg: StringConstants.optionTakeAPhoto);
      pickFromCamera();
      Navigator.of(context, rootNavigator: true).pop();
    },
    chooseFromGallery: () {
      Fluttertoast.showToast(msg: StringConstants.optionChooseFromGallery);
      pickFromGallery();
      Navigator.of(context, rootNavigator: true).pop();
    },
    chooseDocument: () {
      Fluttertoast.showToast(msg: StringConstants.optionChooseDocument);
      Navigator.of(context, rootNavigator: true).pop();
    },
    onCancelButtonPressed: () {
      Fluttertoast.showToast(msg: StringConstants.optionCancel);
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => dialog);
}

Future<File?> pickFromGallery() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageTemp = File(image.path);
      debugPrint("TAG_GALLERY_IMAGE_PATH ${imageTemp.path.toString()}");
      Fluttertoast.showToast(msg: "Gallery Image ${imageTemp.path.toString()}");
      return imageTemp;
    } else {
      return null;
    }
  } on PlatformException catch (exception) {
    debugPrint("TAG_EXCEPTION ${exception.toString()}");
  }
  return null;
}

Future<File?> pickFromCamera() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageTemp = File(image.path);
      debugPrint("TAG_CAMERA_IMAGE_PATH ${imageTemp.path.toString()}");
      Fluttertoast.showToast(msg: "Camera Image ${imageTemp.path.toString()}");
      return imageTemp;
    } else {
      return null;
    }
  } on PlatformException catch (exception) {
    debugPrint("TAG_EXCEPTION ${exception.toString()}");
  }
  return null;
}
