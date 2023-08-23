class ExpenseType {
  int? id;
  String? type;
  bool? enabled;
  String? name;

  ExpenseType({this.id, this.type, this.enabled, this.name});

  ExpenseType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    enabled = json['enabled'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['enabled'] = enabled;
    data['name'] = name;
    return data;
  }
}
