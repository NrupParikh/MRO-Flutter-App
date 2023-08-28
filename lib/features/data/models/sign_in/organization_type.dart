import 'package:floor/floor.dart';

@entity
class OrganizationType {
  @primaryKey
  int? id;
  @ColumnInfo(name: 'organizationId')
  int? organizationId;
  String? code;
  String? name;

  OrganizationType({this.id, required this.organizationId, this.code, this.name});

  OrganizationType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organizationId'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organizationId'] = organizationId;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
