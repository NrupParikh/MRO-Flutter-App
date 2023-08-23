class Values {
  int? id;
  int? version;
  int? attributeId;
  String? attributeType;
  String? value;

  Values({this.id, this.version, this.attributeId, this.attributeType, this.value});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    attributeId = json['attributeId'];
    attributeType = json['attributeType'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['attributeId'] = attributeId;
    data['attributeType'] = attributeType;
    data['value'] = value;
    return data;
  }
}
