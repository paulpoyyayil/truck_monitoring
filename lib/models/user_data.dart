class UserModel {
  UserModelData? data;
  String? message;
  bool? success;

  UserModel({this.data, this.message, this.success});

  UserModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new UserModelData.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class UserModelData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? location;
  String? role;
  String? status;
  int? loginId;

  UserModelData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.location,
      this.role,
      this.status,
      this.loginId});

  UserModelData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['role'] = this.role;
    data['status'] = this.status;
    data['login_id'] = this.loginId;
    return data;
  }
}
