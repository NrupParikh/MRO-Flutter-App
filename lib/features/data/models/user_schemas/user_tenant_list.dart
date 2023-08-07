class UserTenantList {
  int? id;
  int? version;
  String? name;
  String? schemaName;
  String? dataSourceId;
  int? status;
  List<int>? created;
  Null? lastUpdated;
  String? timezone;

  UserTenantList(
      {this.id,
      this.version,
      this.name,
      this.schemaName,
      this.dataSourceId,
      this.status,
      this.created,
      this.lastUpdated,
      this.timezone});

  UserTenantList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    name = json['name'];
    schemaName = json['schemaName'];
    dataSourceId = json['dataSourceId'];
    status = json['status'];
    created = json['created'].cast<int>();
    lastUpdated = json['lastUpdated'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['name'] = name;
    data['schemaName'] = schemaName;
    data['dataSourceId'] = dataSourceId;
    data['status'] = status;
    data['created'] = created;
    data['lastUpdated'] = lastUpdated;
    data['timezone'] = timezone;
    return data;
  }
}
