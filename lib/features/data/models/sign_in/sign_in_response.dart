import 'employee.dart';

class SignInResponse {
  bool? isEmployee;
  bool? isApprover;
  Employee? employee;
  String? token;

  SignInResponse({this.isEmployee, this.isApprover, this.employee, this.token});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    isEmployee = json['isEmployee'];
    isApprover = json['isApprover'];
    employee = json['Employee'] != null ? Employee.fromJson(json['Employee']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isEmployee'] = isEmployee;
    data['isApprover'] = isApprover;
    if (employee != null) {
      data['Employee'] = employee!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
