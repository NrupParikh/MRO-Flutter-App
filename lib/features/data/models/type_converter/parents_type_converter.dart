import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:mro/features/data/models/sign_in/parent.dart';

class ParentConverter extends TypeConverter<Parent?, String> {
  @override
  Parent decode(String databaseValue) {
    return Parent.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Parent? value) {
    return json.encode(value);
  }
}
