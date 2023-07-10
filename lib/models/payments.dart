class PaymentsModel {
  List<PaymentsModelData>? data;
  String? message;
  bool? success;

  PaymentsModel({this.data, this.message, this.success});

  PaymentsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentsModelData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentsModelData.fromJson(v));
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
  int? truck;
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
      this.truck,
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
    truck = json['truck'];
    load = json['load'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['truck_name'] = this.truckName;
    data['driver_name'] = this.driverName;
    data['load_quantity'] = this.loadQuantity;
    data['starting'] = this.starting;
    data['ending'] = this.ending;
    data['amount'] = this.amount;
    data['payment_date'] = this.paymentDate;
    data['date'] = this.date;
    data['status'] = this.status;
    data['user'] = this.user;
    data['driver'] = this.driver;
    data['truck'] = this.truck;
    data['load'] = this.load;
    return data;
  }
}
