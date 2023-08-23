import 'package:mro/features/data/models/get_expense_list/expense_list.dart';

class GetExpenseList {
  int? count;
  List<ExpenseList>? list;

  GetExpenseList({this.count, this.list});

  GetExpenseList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <ExpenseList>[];
      json['list'].forEach((v) {
        list!.add(ExpenseList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
