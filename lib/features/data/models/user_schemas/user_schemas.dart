import 'package:mro/features/data/models/user_schemas/user_tenant_list.dart';

class UserSchemas {
  bool? success;
  List<UserTenantList>? userTenantList;
  String? message;

  UserSchemas({this.success, this.userTenantList, this.message});

  UserSchemas.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['userTenantList'] != null) {
      userTenantList = <UserTenantList>[];
      json['userTenantList'].forEach((v) {
        userTenantList!.add(UserTenantList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (userTenantList != null) {
      data['userTenantList'] = userTenantList!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}
