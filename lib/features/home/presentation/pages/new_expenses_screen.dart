import 'package:flutter/material.dart';
import 'package:mro/config/string_constants.dart';

import '../../../../config/color_constants.dart';

class NewExpensesScreen extends StatefulWidget {
  const NewExpensesScreen({super.key});

  @override
  State<NewExpensesScreen> createState() => _NewExpensesScreenState();
}

class _NewExpensesScreenState extends State<NewExpensesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(StringConstants.newExpense,
              style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.blueThemeColor,
        ),
        body: const Center(child: Text("New Expenses")));
  }
}
