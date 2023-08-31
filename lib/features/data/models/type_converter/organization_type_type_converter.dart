import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/organization_type.dart';

class OrganizationTypeConverter extends TypeConverter<OrganizationType?, String> {
  @override
  OrganizationType? decode(String databaseValue) {
    if (databaseValue.isEmpty) return null;
    return OrganizationType.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(OrganizationType? value) {
    if (value == null) return '';
    return json.encode(value);
  }
}
