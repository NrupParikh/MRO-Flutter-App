import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/data/models/sign_in/attributes.dart';

class AccountsListConverter extends TypeConverter<List<Accounts>, String> {
  @override
  List<Accounts> decode(String databaseValue) {
    final List<dynamic> mapList = json.decode(databaseValue);
    return mapList.map((map) => Accounts.fromJson(map)).toList();
  }

  @override
  String encode(List<Accounts> value) {
    return json.encode(value.map((org) => org.toJson()).toList());
  }
}
