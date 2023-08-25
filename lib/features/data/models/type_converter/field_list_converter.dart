import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/data/models/sign_in/attributes.dart';
import 'package:mro/features/data/models/sign_in/fields.dart';

class FieldsListConverter extends TypeConverter<List<Fields>, String> {
  @override
  List<Fields> decode(String databaseValue) {
    final List<dynamic> mapList = json.decode(databaseValue);
    return mapList.map((map) => Fields.fromJson(map)).toList();
  }

  @override
  String encode(List<Fields> value) {
    return json.encode(value.map((org) => org.toJson()).toList());
  }
}
