class Attributes {
  int? id;
  int? version;
  String? value;
  String? name;

  Attributes({this.id, this.version, this.value, this.name});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    value = json['value'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['value'] = value;
    data['name'] = name;
    return data;
  }
}
