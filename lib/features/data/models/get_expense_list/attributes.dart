import 'package:mro/features/data/models/get_expense_list/description.dart';

class Attributes {
  Description? description;
  Description? participants;

  Attributes({this.description, this.participants});

  Attributes.fromJson(Map<String, dynamic> json) {
    description = json['Description'] != null ? Description.fromJson(json['Description']) : null;
    participants = json['Participants'] != null ? Description.fromJson(json['Participants']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (description != null) {
      data['Description'] = description!.toJson();
    }
    if (participants != null) {
      data['Participants'] = participants!.toJson();
    }
    return data;
  }
}
