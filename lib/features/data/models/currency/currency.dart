import 'package:floor/floor.dart';

import '../sign_in/country.dart';

@entity
class Currency {
  @PrimaryKey(autoGenerate: false)
  int? id;
  int? version;
  String? name;
  String? iso;
  String? prefix;
  String? postfix;
  String? currencyFormat;

  // Fetching Country object data and assign to countryId and countryName directly
  int? countryId;
  String? countryName;

  Currency({this.id, this.version, this.name, this.iso, this.prefix, this.postfix, this.currencyFormat});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    name = json['name'];
    iso = json['iso'];
    prefix = json['prefix'];
    postfix = json['postfix'];
    currencyFormat = json['currencyFormat'];
    if (json["country"] != null) {
      var countryData = Country.fromJson(json["country"]);
      countryId = countryData.id;
      countryName = countryData.name;
    }
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
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    return data;
  }
}
