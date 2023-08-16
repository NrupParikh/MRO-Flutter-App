import 'fields.dart';

class Accounts {
  int? id;
  int? version;
  String? name;
  bool? active;
  String? div;
  String? dept;
  String? account;
  String? sub;
  bool? receiptVerifyRequired;
  String? thresholdAmount;
  bool? receiptUploadRequired;
  List<Fields>? fields;
  String? identifier;

  Accounts(
      {this.id,
      this.version,
      this.name,
      this.active,
      this.div,
      this.dept,
      this.account,
      this.sub,
      this.receiptVerifyRequired,
      this.thresholdAmount,
      this.receiptUploadRequired,
      this.fields,
      this.identifier});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    name = json['name'];
    active = json['active'];
    div = json['div'];
    dept = json['dept'];
    account = json['account'];
    sub = json['sub'];
    receiptVerifyRequired = json['receiptVerifyRequired'];
    thresholdAmount = json['thresholdAmount'].toString();
    receiptUploadRequired = json['receiptUploadRequired'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
    identifier = json['identifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['name'] = name;
    data['active'] = active;
    data['div'] = div;
    data['dept'] = dept;
    data['account'] = account;
    data['sub'] = sub;
    data['receiptVerifyRequired'] = receiptVerifyRequired;
    data['thresholdAmount'] = thresholdAmount;
    data['receiptUploadRequired'] = receiptUploadRequired;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    data['identifier'] = identifier;
    return data;
  }
}
