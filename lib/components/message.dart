import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final String senderEmail;
  final String senderImage;
  final String receiverId;
  final String receiverEmail;
  final String receiverImage;
  final String content;
  final DateTime dateRead;
  final DateTime dateSent;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderEmail,
    required this.senderImage,
    required this.receiverId,
    required this.receiverEmail,
    required this.receiverImage,
    required this.content,
    required this.dateRead,
    required this.dateSent,
  });

  factory Message.fromJson(Map<String, dynamic> map) => Message(
      id: map["id"],
      senderId: map["senderId"], // 1
      senderEmail: map["senderEmail"], // 3
      senderImage: map["senderPhotoUrl"],
      receiverId: map["recipientId"], // 2
      receiverEmail: map["recipientEmail"], // 4
      receiverImage: map["recipientPhotoUrl"],
      content: map['content'], // 5
      dateRead: map['dateRead'] == null
          ? DateTime(1960)
          : DateTime.parse(map['dateRead']),
      dateSent: map['messageSent'] == null
          ? DateTime(1960)
          : DateTime.parse(map['messageSent']),
  );

  @override
  List<Object?> get props => [id];
}
