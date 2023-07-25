class BookingsModel {
  List<BookingsModelData>? data;
  String? message;
  bool? success;

  BookingsModel({this.data, this.message, this.success});

  BookingsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookingsModelData>[];
      json['data'].forEach((v) {
        data!.add(BookingsModelData.fromJson(v));
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

class BookingsModelData {
  int? id;
  int? userId;
  int? driverId;
  String? username;
  int? truckId;
  String? truckName;
  String? driverName;
  int? loadId;
  String? loadQuantity;
  String? starting;
  String? ending;
  String? date;
  String? status;
  String? amount;
  String? paymentDate;

  BookingsModelData({
    this.id,
    this.userId,
    this.driverId,
    this.username,
    this.truckId,
    this.truckName,
    this.driverName,
    this.loadId,
    this.loadQuantity,
    this.starting,
    this.ending,
    this.date,
    this.status,
    this.amount,
    this.paymentDate,
  });

  BookingsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    username = json['username'];
    truckId = json['truck_id'];
    truckName = json['truck_name'];
    driverName = json['driver_name'];
    loadId = json['load_id'];
    loadQuantity = json['load_quantity'];
    starting = json['starting'];
    ending = json['ending'];
    date = json['date'];
    status = json['status'];
    amount = json['amount'];
    paymentDate = json['payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['username'] = username;
    data['truck_id'] = truckId;
    data['truck_name'] = truckName;
    data['driver_name'] = driverName;
    data['load_id'] = loadId;
    data['load_quantity'] = loadQuantity;
    data['starting'] = starting;
    data['ending'] = ending;
    data['date'] = date;
    data['status'] = status;
    data['amount'] = amount;
    data['payment_date'] = paymentDate;
    return data;
  }
}
