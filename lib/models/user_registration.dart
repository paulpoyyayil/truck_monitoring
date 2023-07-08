class UserRegistrationModel {
  UserRegistrationData? data;
  String? message;
  bool? success;

  UserRegistrationModel({this.data, this.message, this.success});

  UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? UserRegistrationData.fromJson(json['data'])
        : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class UserRegistrationData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? location;
  String? role;
  String? status;
  int? loginId;

  UserRegistrationData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.location,
      this.role,
      this.status,
      this.loginId});

  UserRegistrationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    location = json['location'];
    role = json['role'];
    status = json['status'];
    loginId = json['login_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['location'] = location;
    data['role'] = role;
    data['status'] = status;
    data['login_id'] = loginId;
    return data;
  }
}
