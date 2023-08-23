import 'package:mro/features/data/models/get_expense_list/currency.dart';

class CreditCardStatement {
  int? id;
  List<int>? postingDate;
  List<int>? transactionDate;
  List<int>? dueDate;
  String? transactionTime;
  String? account;
  String? cardOwnerName;
  String? transactionType;
  double? amountInNativeCurrency;
  Currency? currency;
  double? exchangeRate;
  double? transactionAmount;
  String? vendor;
  String? terminalId;
  String? transactionId;
  String? city;
  String? description;

  CreditCardStatement(
      {this.id,
      this.postingDate,
      this.transactionDate,
      this.dueDate,
      this.transactionTime,
      this.account,
      this.cardOwnerName,
      this.transactionType,
      this.amountInNativeCurrency,
      this.currency,
      this.exchangeRate,
      this.transactionAmount,
      this.vendor,
      this.terminalId,
      this.transactionId,
      this.city,
      this.description});

  CreditCardStatement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postingDate = json['postingDate'].cast<int>();
    transactionDate = json['transactionDate'].cast<int>();
    dueDate = json['dueDate'].cast<int>();
    transactionTime = json['transactionTime'];
    account = json['account'];
    cardOwnerName = json['cardOwnerName'];
    transactionType = json['transactionType'];
    amountInNativeCurrency = json['amountInNativeCurrency'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    exchangeRate = json['exchangeRate'];
    transactionAmount = json['transactionAmount'];
    vendor = json['vendor'];
    terminalId = json['terminalId'];
    transactionId = json['transactionId'];
    city = json['city'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postingDate'] = postingDate;
    data['transactionDate'] = transactionDate;
    data['dueDate'] = dueDate;
    data['transactionTime'] = transactionTime;
    data['account'] = account;
    data['cardOwnerName'] = cardOwnerName;
    data['transactionType'] = transactionType;
    data['amountInNativeCurrency'] = amountInNativeCurrency;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    data['exchangeRate'] = exchangeRate;
    data['transactionAmount'] = transactionAmount;
    data['vendor'] = vendor;
    data['terminalId'] = terminalId;
    data['transactionId'] = transactionId;
    data['city'] = city;
    data['description'] = description;
    return data;
  }
}
