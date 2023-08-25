import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/organizations.dart';


class OrganizationsListConverter extends TypeConverter<List<Organizations>, String> {
  @override
  List<Organizations> decode(String databaseValue) {
    final List<dynamic> mapList = json.decode(databaseValue);
    return mapList.map((map) => Organizations.fromJson(map)).toList();
  }

  @override
  String encode(List<Organizations> value) {
    return json.encode(value.map((org) => org.toJson()).toList());
  }
}
