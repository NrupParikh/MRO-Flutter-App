import 'package:mro/features/data/models/get_expense_list/account.dart';
import 'package:mro/features/data/models/get_expense_list/amount.dart';
import 'package:mro/features/data/models/get_expense_list/attachments.dart';
import 'package:mro/features/data/models/get_expense_list/attributes.dart';
import 'package:mro/features/data/models/get_expense_list/credit_card_statement.dart';
import 'package:mro/features/data/models/get_expense_list/current_state.dart';
import 'package:mro/features/data/models/get_expense_list/expense_attribute.dart';
import 'package:mro/features/data/models/get_expense_list/expense_type.dart';

class ExpenseList {
  int? id;
  int? version;
  List<int>? created;
  List<int>? lastUpdated;
  int? employeeId;
  Amount? amount;
  Attributes? attributes;
  CreditCardStatement? creditCardStatement;
  CurrentState? currentState;
  Account? account;
  ExpenseType? expenseType;
  String? auditEntries;
  int? reportId;
  bool? isDeleted;
  List<Attachments>? attachments;
  bool? receiptVerified;
  double? primaryAmount;
  double? secondaryAmount;
  int? organizationId;
  List<ExpenseAttribute>? expenseAttribute;
  bool? deleteAllowed;

  ExpenseList(
      {this.id,
      this.version,
      this.created,
      this.lastUpdated,
      this.employeeId,
      this.amount,
      this.attributes,
      this.creditCardStatement,
      this.currentState,
      this.account,
      this.expenseType,
      this.auditEntries,
      this.reportId,
      this.isDeleted,
      this.attachments,
      this.receiptVerified,
      this.primaryAmount,
      this.secondaryAmount,
      this.organizationId,
      this.expenseAttribute,
      this.deleteAllowed});

  ExpenseList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    created = json['created'].cast<int>();
    lastUpdated = json['lastUpdated'].cast<int>();
    employeeId = json['employeeId'];
    amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
    attributes = json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null;
    creditCardStatement = json['creditCardStatement'] != null ? CreditCardStatement.fromJson(json['creditCardStatement']) : null;
    currentState = json['currentState'] != null ? CurrentState.fromJson(json['currentState']) : null;
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
    expenseType = json['expenseType'] != null ? ExpenseType.fromJson(json['expenseType']) : null;
    auditEntries = json['auditEntries'];
    reportId = json['reportId'];
    isDeleted = json['isDeleted'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    receiptVerified = json['receiptVerified'];
    primaryAmount = json['primaryAmount'];
    secondaryAmount = json['secondaryAmount'];
    organizationId = json['organizationId'];
    if (json['expenseAttribute'] != null) {
      expenseAttribute = <ExpenseAttribute>[];
      json['expenseAttribute'].forEach((v) {
        expenseAttribute!.add(ExpenseAttribute.fromJson(v));
      });
    }
    deleteAllowed = json['deleteAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['created'] = created;
    data['lastUpdated'] = lastUpdated;
    data['employeeId'] = employeeId;
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    if (creditCardStatement != null) {
      data['creditCardStatement'] = creditCardStatement!.toJson();
    }
    if (currentState != null) {
      data['currentState'] = currentState!.toJson();
    }
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (expenseType != null) {
      data['expenseType'] = expenseType!.toJson();
    }
    data['auditEntries'] = auditEntries;
    data['reportId'] = reportId;
    data['isDeleted'] = isDeleted;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['receiptVerified'] = receiptVerified;
    data['primaryAmount'] = primaryAmount;
    data['secondaryAmount'] = secondaryAmount;
    data['organizationId'] = organizationId;
    if (expenseAttribute != null) {
      data['expenseAttribute'] = expenseAttribute!.map((v) => v.toJson()).toList();
    }
    data['deleteAllowed'] = deleteAllowed;
    return data;
  }
}
