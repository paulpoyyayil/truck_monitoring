class ChatsModel {
  List<ChatsModelData>? data;
  String? message;
  bool? success;

  ChatsModel({this.data, this.message, this.success});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatsModelData>[];
      json['data'].forEach((v) {
        data!.add(ChatsModelData.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['username'] = userName;
    data['drivername'] = driverName;
    data['chat'] = chat;
    data['date'] = date;
    data['replay'] = replay;
    data['chat_status'] = chatStatus;
    return data;
  }
}
