class UserViewLoadModel {
  List<UserViewLoadData>? data;
  String? message;
  bool? success;

  UserViewLoadModel({this.data, this.message, this.success});

  UserViewLoadModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserViewLoadData>[];
      json['data'].forEach((v) {
        data!.add(UserViewLoadData.fromJson(v));
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

class UserViewLoadData {
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

  UserViewLoadData(
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

  UserViewLoadData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['load_id'] = loadId;
    data['username'] = username;
    data['drivername'] = drivername;
    data['load_from'] = loadFrom;
    data['load_to'] = loadTo;
    data['load_quantity'] = loadQuantity;
    data['amount'] = amount;
    data['status'] = status;
    return data;
  }
}
