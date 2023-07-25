class TruckListingModel {
  List<TruckListingData>? data;
  String? message;
  bool? success;

  TruckListingModel({this.data, this.message, this.success});

  TruckListingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TruckListingData>[];
      json['data'].forEach((v) {
        data!.add(TruckListingData.fromJson(v));
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
