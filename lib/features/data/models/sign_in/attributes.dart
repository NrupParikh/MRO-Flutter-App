import 'package:floor/floor.dart';

@entity
class Attributes {
  @primaryKey
  int? id;
  @ColumnInfo(name: 'organizationId')
  int? organizationId;
  int? version;
  String? value;
  String? name;


  Attributes({this.id, required this.organizationId, this.version, this.value, this.name});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organizationId'];
    version = json['version'];
    value = json['value'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organizationId'] = organizationId;
    data['version'] = version;
    data['value'] = value;
    data['name'] = name;
    return data;
  }
}
