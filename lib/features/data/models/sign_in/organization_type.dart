import 'package:floor/floor.dart';

@entity
class OrganizationType {
  @primaryKey
  int? id;
  String? code;
  String? name;

  OrganizationType({this.id, this.code, this.name});

  OrganizationType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
