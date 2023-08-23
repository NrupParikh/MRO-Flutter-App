class CurrentState {
  int? id;
  String? name;
  int? workflowDefinitionId;

  CurrentState({this.id, this.name, this.workflowDefinitionId});

  CurrentState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    workflowDefinitionId = json['workflowDefinitionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['workflowDefinitionId'] = workflowDefinitionId;
    return data;
  }
}
