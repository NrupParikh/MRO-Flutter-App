class ExpenseAttribute {
  int? id;
  String? label;
  String? value;

  ExpenseAttribute({this.id, this.label, this.value});

  ExpenseAttribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
