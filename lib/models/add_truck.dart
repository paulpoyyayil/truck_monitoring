class AddTruckModel {
  AddTruckData? data;
  String? message;
  bool? success;

  AddTruckModel({this.data, this.message, this.success});

  AddTruckModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AddTruckData.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class AddTruckData {
  int? id;
  String? driverName;
  String? truckName;
  String? trucknumber;
  String? truckfrom;
  String? truckto;
  String? loadCapacity;
  String? status;
  int? driver;

  AddTruckData(
      {this.id,
      this.driverName,
      this.truckName,
      this.trucknumber,
      this.truckfrom,
      this.truckto,
      this.loadCapacity,
      this.status,
      this.driver});

  AddTruckData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverName = json['driver_name'];
    truckName = json['truck_name'];
    trucknumber = json['trucknumber'];
    truckfrom = json['truckfrom'];
    truckto = json['truckto'];
    loadCapacity = json['load_capacity'];
    status = json['status'];
    driver = json['driver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driver_name'] = driverName;
    data['truck_name'] = truckName;
    data['trucknumber'] = trucknumber;
    data['truckfrom'] = truckfrom;
    data['truckto'] = truckto;
    data['load_capacity'] = loadCapacity;
    data['status'] = status;
    data['driver'] = driver;
    return data;
  }
}
