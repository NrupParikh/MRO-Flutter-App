import 'package:floor/floor.dart';
import 'package:mro/features/data/models/type_converter/organizations_list_type_converter.dart';
import 'package:mro/features/data/models/sign_in/organizations.dart';

@entity
class Employee {
  @primaryKey
  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? initials;
  String? phone;
  String? email;
  String? externalIdentifier;
  String? account;

  @TypeConverters([OrganizationsListConverter])
  late List<Organizations> organizations;
  String? vendorCode;
  bool? isCompanyCreditCardHolder;

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      this.initials,
      this.phone,
      this.email,
      this.externalIdentifier,
      this.account,
      required this.organizations,
      this.vendorCode,
      this.isCompanyCreditCardHolder});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    initials = json['initials'];
    phone = json['phone'];
    email = json['email'];
    externalIdentifier = json['externalIdentifier'];
    account = json['account'];
    if (json['organizations'] != null) {
      organizations = <Organizations>[];
      json['organizations'].forEach((v) {
        organizations!.add(Organizations.fromJson(v));
      });
    }
    vendorCode = json['vendorCode'];
    isCompanyCreditCardHolder = json['isCompanyCreditCardHolder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['initials'] = initials;
    data['phone'] = phone;
    data['email'] = email;
    data['externalIdentifier'] = externalIdentifier;
    data['account'] = account;
    if (organizations != null) {
      data['organizations'] = organizations!.map((v) => v.toJson()).toList();
    }
    data['vendorCode'] = vendorCode;
    data['isCompanyCreditCardHolder'] = isCompanyCreditCardHolder;
    return data;
  }
}
