class DriverListModel {
  List<DriverListData>? data;
  String? message;
  bool? success;

  DriverListModel({this.data, this.message, this.success});

  DriverListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DriverListData>[];
      json['data'].forEach((v) {
        data!.add(new DriverListData.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login_id_id'] = this.loginIdId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['vehicle_status'] = this.vehicleStatus;
    data['licence_no'] = this.licenceNo;
    data['role'] = this.role;
    data['status'] = this.status;
    data['transport_from'] = this.transportFrom;
    data['transport_to'] = this.transportTo;
    return data;
  }
}
