class PaymentsModel {
  List<PaymentsModelData>? data;
  String? message;
  bool? success;

  PaymentsModel({this.data, this.message, this.success});

  PaymentsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentsModelData>[];
      json['data'].forEach((v) {
        data!.add(PaymentsModelData.fromJson(v));
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

class PaymentsModelData {
  int? id;
  String? username;
  String? truckName;
  String? driverName;
  String? loadQuantity;
  String? starting;
  String? ending;
  String? amount;
  String? paymentDate;
  String? date;
  String? status;
  int? user;
  int? driver;
  int? truckId;
  int? load;

  PaymentsModelData(
      {this.id,
      this.username,
      this.truckName,
      this.driverName,
      this.loadQuantity,
      this.starting,
      this.ending,
      this.amount,
      this.paymentDate,
      this.date,
      this.status,
      this.user,
      this.driver,
      this.truckId,
      this.load});

  PaymentsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    truckName = json['truck_name'];
    driverName = json['driver_name'];
    loadQuantity = json['load_quantity'];
    starting = json['starting'];
    ending = json['ending'];
    amount = json['amount'];
    paymentDate = json['payment_date'];
    date = json['date'];
    status = json['status'];
    user = json['user'];
    driver = json['driver'];
    truckId = json['truck_id'];
    load = json['load'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['truck_name'] = truckName;
    data['driver_name'] = driverName;
    data['load_quantity'] = loadQuantity;
    data['starting'] = starting;
    data['ending'] = ending;
    data['amount'] = amount;
    data['payment_date'] = paymentDate;
    data['date'] = date;
    data['status'] = status;
    data['user'] = user;
    data['driver'] = driver;
    data['truck_id'] = truckId;
    data['load'] = load;
    return data;
  }
}
