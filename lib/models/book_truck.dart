class BookTruckModel {
  BookTruckData? data;
  String? message;
  bool? success;

  BookTruckModel({this.data, this.message, this.success});

  BookTruckModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new BookTruckData.fromJson(json['data']) : null;
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

class BookTruckData {
  int? id;
  String? username;
  String? truckName;
  String? driverName;
  String? loadQuantity;
  String? starting;
  String? ending;
  String? date;
  String? status;
  int? user;
  int? driver;
  int? truck;
  int? load;

  BookTruckData(
      {this.id,
      this.username,
      this.truckName,
      this.driverName,
      this.loadQuantity,
      this.starting,
      this.ending,
      this.date,
      this.status,
      this.user,
      this.driver,
      this.truck,
      this.load});

  BookTruckData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    truckName = json['truck_name'];
    driverName = json['driver_name'];
    loadQuantity = json['load_quantity'];
    starting = json['starting'];
    ending = json['ending'];
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
    data['date'] = this.date;
    data['status'] = this.status;
    data['user'] = this.user;
    data['driver'] = this.driver;
    data['truck'] = this.truck;
    data['load'] = this.load;
    return data;
  }
}
