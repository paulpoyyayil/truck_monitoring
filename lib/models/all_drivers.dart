class AllDriverModel {
  List<Data>? data;
  String? message;
  bool? success;

  AllDriverModel({this.data, this.message, this.success});

  AllDriverModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? location;
  String? vehicleStatus;
  String? licenceNo;
  String? role;
  String? status;
  String? transportFrom;
  String? transportTo;
  int? loginId;

  Data(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.location,
      this.vehicleStatus,
      this.licenceNo,
      this.role,
      this.status,
      this.transportFrom,
      this.transportTo,
      this.loginId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    location = json['location'];
    vehicleStatus = json['vehicle_status'];
    licenceNo = json['licence_no'];
    role = json['role'];
    status = json['status'];
    transportFrom = json['transport_from'];
    transportTo = json['transport_to'];
    loginId = json['login_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['location'] = location;
    data['vehicle_status'] = vehicleStatus;
    data['licence_no'] = licenceNo;
    data['role'] = role;
    data['status'] = status;
    data['transport_from'] = transportFrom;
    data['transport_to'] = transportTo;
    data['login_id'] = loginId;
    return data;
  }
}
