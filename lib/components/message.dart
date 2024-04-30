import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String media;
  final DateTime dateSent;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.media,
    required this.dateSent,
  });

  factory Message.fromJson(Map<String, dynamic> map) => Message(
        id: map["id"],
        senderId: map["senderId"],
        receiverId: map["receiverId"],
        media: map["mediaUrl"] ?? "",
        content: map['message'],
        dateSent: map['timestamp'] == null
            ? DateTime(1960)
            : DateTime.parse(map['timestamp']),
      );

  @override
  List<Object?> get props => [id];
}
