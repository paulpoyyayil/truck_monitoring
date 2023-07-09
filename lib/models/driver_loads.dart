class DriverLoadsModel {
  List<DriverLoadsModelData>? data;
  String? message;
  bool? success;

  DriverLoadsModel({this.data, this.message, this.success});

  DriverLoadsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DriverLoadsModelData>[];
      json['data'].forEach((v) {
        data!.add(new DriverLoadsModelData.fromJson(v));
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

class DriverLoadsModelData {
  int? id;
  int? userId;
  int? driverId;
  int? loadId;
  String? username;
  String? drivername;
  String? loadFrom;
  String? loadTo;
  String? loadQuantity;
  String? amount;
  String? status;

  DriverLoadsModelData(
      {this.id,
      this.userId,
      this.driverId,
      this.loadId,
      this.username,
      this.drivername,
      this.loadFrom,
      this.loadTo,
      this.loadQuantity,
      this.amount,
      this.status});

  DriverLoadsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    loadId = json['load_id'];
    username = json['username'];
    drivername = json['drivername'];
    loadFrom = json['load_from'];
    loadTo = json['load_to'];
    loadQuantity = json['load_quantity'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['driver_id'] = this.driverId;
    data['load_id'] = this.loadId;
    data['username'] = this.username;
    data['drivername'] = this.drivername;
    data['load_from'] = this.loadFrom;
    data['load_to'] = this.loadTo;
    data['load_quantity'] = this.loadQuantity;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}
