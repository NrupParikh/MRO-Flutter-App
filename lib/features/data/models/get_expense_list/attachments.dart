import 'package:mro/features/data/models/get_expense_list/file_type.dart';

class Attachments {
  int? id;
  int? version;
  FileType? fileType;
  String? fileName;
  String? s3Location;

  Attachments({this.id, this.version, this.fileType, this.fileName, this.s3Location});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    fileType = json['fileType'] != null ? FileType.fromJson(json['fileType']) : null;
    fileName = json['fileName'];
    s3Location = json['s3Location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    if (fileType != null) {
      data['fileType'] = fileType!.toJson();
    }
    data['fileName'] = fileName;
    data['s3Location'] = s3Location;
    return data;
  }
}
