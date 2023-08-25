import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/attributes.dart';

class AttributesListConverter extends TypeConverter<List<Attributes>, String> {
  @override
  List<Attributes> decode(String databaseValue) {
    final List<dynamic> mapList = json.decode(databaseValue);
    return mapList.map((map) => Attributes.fromJson(map)).toList();
  }

  @override
  String encode(List<Attributes> value) {
    return json.encode(value.map((org) => org.toJson()).toList());
  }
}
