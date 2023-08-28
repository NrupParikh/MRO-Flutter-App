import 'package:floor/floor.dart';

@entity
class Fields {
  @primaryKey
  int? id;
  @ColumnInfo(name: 'accountsId')
  int? accountsId;
  int? version;
  String? label;
  bool? required;
  double? sequence;
  bool? uppercase;
  int? maxLength;

  Fields(
      {this.id,
      required this.accountsId,
      this.version,
      this.label,
      this.required,
      this.sequence,
      this.uppercase,
      this.maxLength});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountsId = json['accountsId'];
    version = json['version'];
    label = json['label'];
    required = json['required'];
    sequence = json['sequence'];
    uppercase = json['uppercase'];
    maxLength = json['maxLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountsId'] = accountsId;
    data['version'] = version;
    data['label'] = label;
    data['required'] = required;
    data['sequence'] = sequence;
    data['uppercase'] = uppercase;
    data['maxLength'] = maxLength;
    return data;
  }
}
