import 'dart:io';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/presentation/home/bloc/new_expense/new_expense_cubit.dart';
import 'package:mro/features/presentation/home/bloc/new_expense/new_expense_state.dart';

import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
import '../../../data/data_sources/local/database/mro_database.dart';
import '../../../data/data_sources/local/database/provider/mro_database_provider.dart';
import '../../../data/models/currency/currency.dart';
import '../../../data/models/sign_in/organizations.dart';
import '../../../domain/repository/providers/mro_repository_provider.dart';
import '../../../widgets/my_custom_widget.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();
bool isPickerClosed = false;

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

  late ImagePicker imagePicker;
  late List<XFile>? imageFileList;
  late NewExpenseCubit newExpenseCubit;

  FocusNode vat1TextFieldFocusNode = FocusNode();
  FocusNode vat2TextFieldFocusNode = FocusNode();
  FocusNode totalVatTextFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      newExpenseCubit = context.read<NewExpenseCubit>();
    });

    organizationList = <OrganizationDropDown>[];
    currencyList = <CurrencyDropDown>[];
    accountList = <AccountDropDown>[];

    isOrganizationDropDownSelected = false;
    isCurrencyDropDownSelected = false;
    isAccountDropDownSelected = false;
    debugPrint("TAG_initState");
    expenseAmountController.text = "0.00";
    imagePicker = ImagePicker();
    imageFileList = [];
    expenseDateController.text = "";
    vat1Controller.addListener(_printLatestValueOfVAT1);
    vat2Controller.addListener(_printLatestValueOfVAT2);
    totalOfVAT1andVAT2.addListener(_printLatestValueOfTotalAmount);
  }

  void _printLatestValueOfVAT1() {
    final text = vat1Controller.text;
    print('vat1Controller text field: $text (${text.characters.length})');
    setExpenseAmount();
  }

  void _printLatestValueOfVAT2() {
    final text = vat2Controller.text;
    print('vat2Controller text field: $text (${text.characters.length})');
    setExpenseAmount();
  }

  void _printLatestValueOfTotalAmount() {
    final text = totalOfVAT1andVAT2.text;
    print('totalOfVAT1andVAT2 text field: $text (${text.characters.length})');
    setExpenseAmount();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    expenseDateController.dispose();
    expenseAmountController.dispose();
    vat1Controller.dispose();
    vat2Controller.dispose();
    totalOfVAT1andVAT2.dispose();
    super.dispose();
    debugPrint("TAG_disposeState");
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    final mroRepository = MroRepositoryProvider.of(context)?.mroRepository;
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    final mroDatabase = MroDatabaseProvider.of(context).database;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.addExpense, style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
        body: BlocConsumer<NewExpenseCubit, NewExpenseState>(
          listenWhen: (context, state) {
            return state is NewExpenseSuccessState ||
                state is NewExpenseFailureState ||
                state is LoadingState ||
                state is NewExpenseRefreshState;
          },
          listener: (context, state) {
            if (state is NewExpenseSuccessState) {
              hideLoading(_dialogKey);
              Fluttertoast.showToast(msg: "");
            } else if (state is NewExpenseFailureState) {
              hideLoading(_dialogKey);
              displayDialog(context, state.newExpenseErrorMessage);
            } else if (state is LoadingState) {
              showLoading(context, _dialogKey);
            } else if (state is NewExpenseRefreshState) {
              setState(() {});
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

              if (organizationList.isNotEmpty && currencyList.isNotEmpty && accountList.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  flex: 7,
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
                                          readOnly: true,
                                          keyboardType: TextInputType.datetime,
                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          controller: expenseDateController,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            hintText: StringConstants.hintSelectExpenseDate,
                                            hintStyle: TextStyle(color: Colors.grey),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                          onTap: () async {
                                            await showDatePickerDialog(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          if (imageFileList!.isNotEmpty) ...[
                                            GestureDetector(
                                              onTap: () {
                                                Fluttertoast.showToast(msg: imageFileList!.last.path.toString());
                                              },
                                              child: Image.file(
                                                File(imageFileList!.last.path),
                                                width: 48,
                                                height: 48,
                                              ),
                                            ),
                                          ],
                                          GestureDetector(
                                            onTap: () {
                                              showChooseOptionDialog(context, imagePicker, imageFileList, newExpenseCubit);
                                            },
                                            child: Image.asset(
                                              "assets/images/ic_camera.png",
                                              width: 48,
                                              height: 48,
                                              color: ColorConstants.blueThemeColor,
                                            ),
                                          ),
                                        ],
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
                                          style: const TextStyle(color: Colors.grey),
                                          keyboardType: TextInputType.number,
                                          maxLines: 1,
                                          controller: expenseAmountController,
                                          enabled: false,
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
                                          textInputAction: TextInputAction.next,
                                          focusNode: vat1TextFieldFocusNode,
                                          onSubmitted: (String value) {
                                            vat2TextFieldFocusNode.requestFocus();
                                          },
                                          keyboardType: TextInputType.number,
                                          maxLines: 1,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        child: TextField(
                                          style: const TextStyle(color: Colors.black),
                                          controller: vat2Controller,
                                          keyboardType: TextInputType.number,
                                          focusNode: vat2TextFieldFocusNode,
                                          onSubmitted: (String value) {
                                            totalVatTextFieldFocusNode.requestFocus();
                                          },
                                          maxLines: 1,
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
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                focusNode: totalVatTextFieldFocusNode,
                                onSubmitted: (String value) {
                                  FocusScope.of(context).unfocus();
                                },
                                maxLines: 1,
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
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                        buttonText: StringConstants.save.toUpperCase(),
                        onPressed: () async {
                          await connectivity.checkConnectivity().then((value) {
                            var expenseDate = expenseDateController.text.toString();
                            var vat1 = vat1Controller.text.toString();
                            var vat2 = vat2Controller.text.toString();
                            var vatTotal = totalOfVAT1andVAT2.text.toString();
                            if (value == ConnectivityResult.none) {
                              newExpenseCubit.submitForm(
                                  mroDatabase, mroRepository!, pref!, false, expenseDate, vat1, vat2, vatTotal);
                            } else {
                              // ToDo YES
                              debugPrint("==================== SAVE INFO ====================");
                              debugPrint("TAG_Organization_Id   = ${drpOrganizationValue.id}");
                              debugPrint("TAG_Organization_Name = ${drpOrganizationValue.name}");
                              debugPrint("TAG_Expense_Date      = ${expenseDateController.text}");
                              debugPrint("TAG_Expense_Amount    = ${expenseAmountController.text}");
                              debugPrint("TAG_Currency_Id       = ${drpCurrencyValue.id}");
                              debugPrint("TAG_Currency_Name     = ${drpCurrencyValue.name}");
                              debugPrint("TAG_VAT1_Amount       = ${vat1Controller.text}");
                              debugPrint("TAG_VAT2_Amount       = ${vat2Controller.text}");
                              debugPrint("TAG_TOTAL_Amount      = ${totalOfVAT1andVAT2.text}");
                              debugPrint("TAG_ComCC_or_Personal = ${radioGroupSelectedValue.toString()}");
                              debugPrint("TAG_Account_Id        = ${drpAccountValue.id}");
                              debugPrint("TAG_Account_Name      = ${drpAccountValue.name}");
                              debugPrint("====================================================");
                              newExpenseCubit.submitForm(
                                  mroDatabase, mroRepository!, pref!, true, expenseDate, vat1, vat2, vatTotal);
                            }
                          });
                        },
                        buttonBgColor: ColorConstants.blueThemeColor,
                        leftPadding: 8,
                        rightPadding: 8),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ));
  }

  void setExpenseAmount() {
    setState(() {
      expenseAmountController.text = expenseAmount(vat1Controller.text, vat2Controller.text, totalOfVAT1andVAT2.text);
    });
  }

  // ======================== DATE PICKER DIALOG
  Future<void> showDatePickerDialog(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      debugPrint("TAG_Picked_date_$pickedDate");
      String formattedDate = DateFormat(AppConstants.dateFormatYYYYMMDD).format(pickedDate);
      debugPrint("TAG_Picked_date_FORMATED_$formattedDate");
      setState(() {
        expenseDateController.text = formattedDate;
      });
    } else {
      debugPrint("TAG_Picked_date_Note_Selected");
      Fluttertoast.showToast(msg: "Expense Date not selected");
    }
  }

  double returnDefaultIfEmpty(String value) {
    if (value.isEmpty) {
      return 0.0;
    } else {
      return double.parse(value);
    }
  }

  String expenseAmount(String vat1, String vat2, String totalVat) {
    double vat1Value = returnDefaultIfEmpty(vat1);
    double vat2Value = returnDefaultIfEmpty(vat2);
    double totalVatValue = returnDefaultIfEmpty(totalVat);
    debugPrint("TAG_vat1Value_$vat1Value");
    debugPrint("TAG_vat2Value_$vat2Value");
    debugPrint("TAG_totalVatValue_$totalVatValue");
    double ans = (totalVatValue - (vat1Value + vat2Value));
    debugPrint("TAG_ans_$ans");
    return ans.toString();
  }

  void displayDialog(BuildContext context, String message) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: message,
      onOkButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      onCancelButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
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

void showChooseOptionDialog(
    BuildContext context, ImagePicker imagePicker, List<XFile>? imageFileList, NewExpenseCubit newExpenseCubit) {
  var dialog = ChooseOptionDialog(
    takeAPhoto: () {
      Fluttertoast.showToast(msg: StringConstants.optionTakeAPhoto);
      pickFromCamera(newExpenseCubit);
      Navigator.of(context, rootNavigator: true).pop();
    },
    chooseFromGallery: () {
      Fluttertoast.showToast(msg: StringConstants.optionChooseFromGallery);
      pickMultipleImageFromGallery(imagePicker, imageFileList, newExpenseCubit);
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

void pickMultipleImageFromGallery(ImagePicker imagePicker, List<XFile>? imageFileList, NewExpenseCubit newExpenseCubit) async {
  try {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    debugPrint("==================== GALLERY IMAGE(S) ====================");
    debugPrint("TAG_Image_List_Length:${imageFileList!.length}");
    if (imageFileList.isNotEmpty) {
      for (int i = 0; i < imageFileList.length; i++) {
        debugPrint("TAG_FILE_PATH_$i      = ${imageFileList[i].path.toString()}");
        debugPrint("TAG_FILE_NAME_$i      = ${imageFileList[i].name.toString()}");
        debugPrint("TAG_FILE_MIME_TYPE_$i = ${imageFileList[i].mimeType.toString()}");
      }
      debugPrint("====================================================");
    }
    newExpenseCubit.refreshUI();
  } on PlatformException catch (exception) {
    debugPrint("TAG_EXCEPTION ${exception.toString()}");
  }

  return null;
}

Future<File?> pickFromCamera(NewExpenseCubit newExpenseCubit) async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageTemp = File(image.path);
      debugPrint("TAG_CAMERA_IMAGE_PATH ${imageTemp.path.toString()}");
      Fluttertoast.showToast(msg: "Camera Image ${imageTemp.path.toString()}");
      isPickerClosed = true;
      return imageTemp;
    } else {
      return null;
    }
  } on PlatformException catch (exception) {
    debugPrint("TAG_EXCEPTION ${exception.toString()}");
  }
  return null;
}
