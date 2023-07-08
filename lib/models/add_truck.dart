class AddTruckModel {
  AddTruckData? data;
  String? message;
  bool? success;

  AddTruckModel({this.data, this.message, this.success});

  AddTruckModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new AddTruckData.fromJson(json['data']) : null;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_name'] = this.driverName;
    data['truck_name'] = this.truckName;
    data['trucknumber'] = this.trucknumber;
    data['truckfrom'] = this.truckfrom;
    data['truckto'] = this.truckto;
    data['load_capacity'] = this.loadCapacity;
    data['status'] = this.status;
    data['driver'] = this.driver;
    return data;
  }
}
