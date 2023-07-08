class TruckListingModel {
  List<TruckListingData>? data;
  String? message;
  bool? success;

  TruckListingModel({this.data, this.message, this.success});

  TruckListingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TruckListingData>[];
      json['data'].forEach((v) {
        data!.add(new TruckListingData.fromJson(v));
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

class TruckListingData {
  int? id;
  String? driverName;
  String? truckName;
  String? trucknumber;
  String? truckfrom;
  String? truckto;
  String? loadCapacity;
  String? status;
  int? driver;

  TruckListingData(
      {this.id,
      this.driverName,
      this.truckName,
      this.trucknumber,
      this.truckfrom,
      this.truckto,
      this.loadCapacity,
      this.status,
      this.driver});

  TruckListingData.fromJson(Map<String, dynamic> json) {
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
