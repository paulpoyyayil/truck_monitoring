class AllLoadsModel {
  List<AllLoadsModelData>? data;
  String? message;
  bool? success;

  AllLoadsModel({this.data, this.message, this.success});

  AllLoadsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllLoadsModelData>[];
      json['data'].forEach((v) {
        data!.add(new AllLoadsModelData.fromJson(v));
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

class AllLoadsModelData {
  int? id;
  String? username;
  String? loadDescription;
  String? loadFrom;
  String? loadTo;
  String? loadQuantity;
  String? status;
  int? user;

  AllLoadsModelData(
      {this.id,
      this.username,
      this.loadDescription,
      this.loadFrom,
      this.loadTo,
      this.loadQuantity,
      this.status,
      this.user});

  AllLoadsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    loadDescription = json['load_description'];
    loadFrom = json['load_from'];
    loadTo = json['load_to'];
    loadQuantity = json['load_quantity'];
    status = json['status'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['load_description'] = this.loadDescription;
    data['load_from'] = this.loadFrom;
    data['load_to'] = this.loadTo;
    data['load_quantity'] = this.loadQuantity;
    data['status'] = this.status;
    data['user'] = this.user;
    return data;
  }
}
