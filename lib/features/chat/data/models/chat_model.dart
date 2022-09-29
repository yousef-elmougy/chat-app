
class ChatModel {
  final String? senderId, text, receiverId;
  final DateTime? dateTime;

  ChatModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        dateTime: json['dateTime'].toDate(),
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'receiverId': receiverId,
        'senderId': senderId,
        'dateTime': dateTime,
        'text': text,
      };
}
