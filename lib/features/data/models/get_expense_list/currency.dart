import 'package:mro/features/data/models/get_expense_list/country.dart';

class Currency {
  int? id;
  int? version;
  String? name;
  String? iso;
  String? prefix;
  String? postfix;
  String? currencyFormat;
  Country? country;

  Currency({this.id, this.version, this.name, this.iso, this.prefix, this.postfix, this.currencyFormat, this.country});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    name = json['name'];
    iso = json['iso'];
    prefix = json['prefix'];
    postfix = json['postfix'];
    currencyFormat = json['currencyFormat'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['name'] = name;
    data['iso'] = iso;
    data['prefix'] = prefix;
    data['postfix'] = postfix;
    data['currencyFormat'] = currencyFormat;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }
}
