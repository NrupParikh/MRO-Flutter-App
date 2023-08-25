import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/organization_type.dart';

class OrganizationTypeConverter extends TypeConverter<OrganizationType?, String> {
  @override
  OrganizationType decode(String databaseValue) {
    return OrganizationType.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(OrganizationType? value) {
    return json.encode(value);
  }
}
