class Fields {
  int? id;
  int? version;
  String? label;
  bool? required;
  double? sequence;
  bool? uppercase;
  int? maxLength;

  Fields(
      {this.id,
        this.version,
        this.label,
        this.required,
        this.sequence,
        this.uppercase,
        this.maxLength});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    label = json['label'];
    required = json['required'];
    sequence = json['sequence'];
    uppercase = json['uppercase'];
    maxLength = json['maxLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['label'] = label;
    data['required'] = required;
    data['sequence'] = sequence;
    data['uppercase'] = uppercase;
    data['maxLength'] = maxLength;
    return data;
  }
}