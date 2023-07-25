class AllUsersModel {
  List<AllUsersModelData>? data;
  String? message;
  bool? success;

  AllUsersModel({this.data, this.message, this.success});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllUsersModelData>[];
      json['data'].forEach((v) {
        data!.add(AllUsersModelData.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class AllUsersModelData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? location;
  String? role;
  String? status;
  int? loginId;

  AllUsersModelData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.location,
      this.role,
      this.status,
      this.loginId});

  AllUsersModelData.fromJson(Map<String, dynamic> json) {
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
