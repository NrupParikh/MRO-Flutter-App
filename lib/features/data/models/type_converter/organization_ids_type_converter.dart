import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/organizations.dart';

class OrganizationIdsConverter extends TypeConverter<List<int>, String> {
  @override
  List<int> decode(String databaseValue) {
    if (databaseValue.isEmpty) return [];
    final List<String> parts = databaseValue.split(',');
    return parts.map((e) => int.parse(e)).toList();
  }

  @override
  String encode(List<int> value) {
    return value.join(',');
  }
}
