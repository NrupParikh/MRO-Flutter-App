import 'package:floor/floor.dart';

@entity
class Parent {
  @primaryKey
  int? id;
  int? version;
  String? name;
  String? externalIdentifier;
  String? abbreviation;

  // List<Attributes>? attributes;
  String? shortDescription;

  // Object? parent;

  // OrganizationType? organizationType;
  int? active;

  // List<Accounts>? accounts;
  bool? activatePrimaryVAT;
  bool? activateSecondaryVAT;

  // Currency? currency;
  bool? substituteSubValue;

  Parent(
      {this.id,
      this.version,
      this.name,
      this.externalIdentifier,
      this.abbreviation,
      // this.attributes,
      this.shortDescription,
      // this.parent,
      // this.organizationType,
      this.active,
      // this.accounts,
      this.activatePrimaryVAT,
      this.activateSecondaryVAT,
      // this.currency,
      this.substituteSubValue});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    name = json['name'];
    externalIdentifier = json['externalIdentifier'];
    abbreviation = json['abbreviation'];
    // if (json['attributes'] != null) {
    //   attributes = <Attributes>[];
    //   json['attributes'].forEach((v) {
    //     attributes!.add(Attributes.fromJson(v));
    //   });
    // }
    shortDescription = json['shortDescription'];
    // parent = json['parent'];
    // organizationType = json['organizationType'] != null ? OrganizationType.fromJson(json['organizationType']) : null;
    active = json['active'];
    // if (json['accounts'] != null) {
    //   accounts = <Accounts>[];
    //   json['accounts'].forEach((v) {
    //     accounts!.add(Accounts.fromJson(v));
    //   });
    // }
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
    // if (attributes != null) {
    //   data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    // }
    data['shortDescription'] = shortDescription;
    //data['parent'] = parent;
    // if (organizationType != null) {
    //   data['organizationType'] = organizationType!.toJson();
    // }
    data['active'] = active;
    // if (accounts != null) {
    //   data['accounts'] = accounts!.map((v) => v.toJson()).toList();
    // }
    data['activatePrimaryVAT'] = activatePrimaryVAT;
    data['activateSecondaryVAT'] = activateSecondaryVAT;
    // if (currency != null) {
    //   data['currency'] = currency!.toJson();
    // }
    data['substituteSubValue'] = substituteSubValue;
    return data;
  }
}
