import 'package:mro/features/data/models/get_expense_list/currency.dart';

class Amount {
  Currency? currency;
  double? amount;

  Amount({this.currency, this.amount});

  Amount.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    data['amount'] = amount;
    return data;
  }
}
