import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mro/features/presentation/home/bloc/new_expense/new_expense_cubit.dart';
import 'package:mro/features/presentation/home/bloc/new_expense/new_expense_state.dart';

import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../data/data_sources/local/database/mro_database.dart';
import '../../../data/models/sign_in/organizations.dart';
import '../../../widgets/my_custom_widget.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();

class NewExpensesScreen extends StatefulWidget {
  const NewExpensesScreen({super.key});

  @override
  State<NewExpensesScreen> createState() => _NewExpensesScreenState();
}

class _NewExpensesScreenState extends State<NewExpensesScreen> {
  late List<OrganizationDropDown> list;
  late OrganizationDropDown dropdownValue;
  late bool isDropDownSelected;

  @override
  void initState() {
    super.initState();
    list = <OrganizationDropDown>[];
    isDropDownSelected = false;
    debugPrint("TAG_initState");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("TAG_disposeState");
  }

  @override
  Widget build(BuildContext context) {
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
              if (isDropDownSelected == false) {
                if (state.organizations.isNotEmpty) {
                  List<Organizations> organizationsFuture = state.organizations;
                  list.clear();
                  for (int i = 0; i < organizationsFuture!.length; i++) {
                    var organizationData = organizationsFuture[i];
                    debugPrint("TAG_organization_Name${organizationsFuture[i].name}");
                    list.add(OrganizationDropDown(organizationData.id, organizationData.name));
                  }
                  dropdownValue = list.first;
                }
              }

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text("New Expense"),
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
                              child: DropdownButton<OrganizationDropDown>(
                                isExpanded: true,
                                // Full width
                                value: dropdownValue,
                                style: const TextStyle(color: Colors.black),
                                underline: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                items: list.map<DropdownMenuItem<OrganizationDropDown>>((OrganizationDropDown value) {
                                  return DropdownMenuItem<OrganizationDropDown>(
                                    value: value,
                                    child: Text(value.name.toString()),
                                  );
                                }).toList(),
                                onChanged: (OrganizationDropDown? value) {
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
                    ],
                  ),
                ),
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
    final organizations = database.mroDao.getOrganizations(employeeId!);
    return organizations;
  }
}

class OrganizationDropDown {
  int? id;
  String? name;

  OrganizationDropDown(this.id, this.name);
}
