import 'package:mro/features/data/models/get_expense_list/expense_attribute_model.dart';
import 'package:mro/features/data/models/get_expense_list/values.dart';

class Description {
  int? id;
  int? version;
  String? name;
  int? expenseId;
  List<Values>? values;
  ExpenseAttributeModel? expenseAttributeModel;

  Description({this.id, this.version, this.name, this.expenseId, this.values, this.expenseAttributeModel});

  Description.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    name = json['name'];
    expenseId = json['expenseId'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
    expenseAttributeModel =
        json['expenseAttributeModel'] != null ? ExpenseAttributeModel.fromJson(json['expenseAttributeModel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['name'] = name;
    data['expenseId'] = expenseId;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    if (expenseAttributeModel != null) {
      data['expenseAttributeModel'] = expenseAttributeModel!.toJson();
    }
    return data;
  }
}
