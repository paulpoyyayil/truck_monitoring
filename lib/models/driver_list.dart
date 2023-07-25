class DriverListModel {
  List<DriverListData>? data;
  String? message;
  bool? success;

  DriverListModel({this.data, this.message, this.success});

  DriverListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DriverListData>[];
      json['data'].forEach((v) {
        data!.add(DriverListData.fromJson(v));
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

class DriverListData {
  int? id;
  int? loginIdId;
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

  DriverListData(
      {this.id,
      this.loginIdId,
      this.name,
      this.email,
      this.mobile,
      this.location,
      this.vehicleStatus,
      this.licenceNo,
      this.role,
      this.status,
      this.transportFrom,
      this.transportTo});

  DriverListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginIdId = json['login_id_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['login_id_id'] = loginIdId;
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
    return data;
  }
}
