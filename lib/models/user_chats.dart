class ChatsModel {
  List<ChatsModelData>? data;
  String? message;
  bool? success;

  ChatsModel({this.data, this.message, this.success});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatsModelData>[];
      json['data'].forEach((v) {
        data!.add(new ChatsModelData.fromJson(v));
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

class ChatsModelData {
  int? id;
  int? userId;
  int? driverId;
  String? userName;
  String? driverName;
  String? chat;
  String? date;
  String? replay;
  String? chatStatus;

  ChatsModelData(
      {this.id,
      this.userId,
      this.driverId,
      this.userName,
      this.driverName,
      this.chat,
      this.date,
      this.replay,
      this.chatStatus});

  ChatsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    userName = json['username'];
    driverName = json['drivername'];
    chat = json['chat'];
    date = json['date'];
    replay = json['replay'];
    chatStatus = json['chat_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['driver_id'] = this.driverId;
    data['username'] = this.userName;
    data['drivername'] = this.driverName;
    data['chat'] = this.chat;
    data['date'] = this.date;
    data['replay'] = this.replay;
    data['chat_status'] = this.chatStatus;
    return data;
  }
}
