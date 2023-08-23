class FileType {
  int? id;
  String? applicationType;

  FileType({this.id, this.applicationType});

  FileType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationType = json['applicationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicationType'] = applicationType;
    return data;
  }
}
