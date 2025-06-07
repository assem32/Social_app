class MessageModel {
  String? senderId;
  String? dateTime;
  String? message;

  MessageModel({
    this.senderId,
    this.dateTime,
    this.message,
  });

  MessageModel.fromJson(Map<dynamic, dynamic> json) {
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    message = json['message'];
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'senderId': senderId,
      'dateTime': dateTime,
      'message': message,
    };
  }
}
