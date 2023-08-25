import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/data/models/sign_in/attributes.dart';
import 'package:mro/features/data/models/sign_in/organization_type.dart';
import 'package:mro/features/data/models/sign_in/parent.dart';
import 'package:mro/features/data/models/type_converter/accounts_list_type_converter.dart';
import 'package:mro/features/data/models/type_converter/attributes_list_type_converter.dart';
import 'package:mro/features/data/models/type_converter/organization_type_type_converter.dart';
import 'package:mro/features/data/models/type_converter/parents_type_converter.dart';

@entity
class Organizations {
  @primaryKey
  int? id;
  int? version;
  String? name;
  String? externalIdentifier;
  String? abbreviation;

  @TypeConverters([AttributesListConverter])
  late List<Attributes> attributes;
  String? shortDescription;

  @TypeConverters([ParentConverter])
  Parent? parent;

  @TypeConverters([OrganizationTypeConverter])
  OrganizationType? organizationType;
  int? active;

  @TypeConverters([AccountsListConverter])
  late List<Accounts> accounts;
  bool? activatePrimaryVAT;
  bool? activateSecondaryVAT;

  // Currency? currency;
  bool? substituteSubValue;

  Organizations(
      {this.id,
      this.version,
      this.name,
      this.externalIdentifier,
      this.abbreviation,
      required this.attributes,
      this.shortDescription,
      this.parent,
      this.organizationType,
      this.active,
      required this.accounts,
      this.activatePrimaryVAT,
      this.activateSecondaryVAT,
      // this.currency,
      this.substituteSubValue});

  Organizations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    name = json['name'];
    externalIdentifier = json['externalIdentifier'];
    abbreviation = json['abbreviation'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    shortDescription = json['shortDescription'];
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    organizationType = json['organizationType'] != null ? OrganizationType.fromJson(json['organizationType']) : null;
    active = json['active'];
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(Accounts.fromJson(v));
      });
    }
    activatePrimaryVAT = json['activatePrimaryVAT'];
    activateSecondaryVAT = json['activateSecondaryVAT'];
    // currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    substituteSubValue = json['substituteSubValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['name'] = name;
    data['externalIdentifier'] = externalIdentifier;
    data['abbreviation'] = abbreviation;
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['shortDescription'] = shortDescription;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    if (organizationType != null) {
      data['organizationType'] = organizationType!.toJson();
    }
    data['active'] = active;
    if (accounts != null) {
      data['accounts'] = accounts!.map((v) => v.toJson()).toList();
    }
    data['activatePrimaryVAT'] = activatePrimaryVAT;
    data['activateSecondaryVAT'] = activateSecondaryVAT;
    // if (currency != null) {
    //   data['currency'] = currency!.toJson();
    // }
    data['substituteSubValue'] = substituteSubValue;
    return data;
  }
}
