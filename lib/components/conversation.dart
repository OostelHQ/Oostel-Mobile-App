import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String id;

  final String lastMessage;
  final String otherUser;
  final DateTime timeStamp;
  final int unreadMessages;
  final String? target;

  const Conversation({
    this.id = "",
    this.target,
    this.lastMessage = "",
    this.otherUser = "",
    this.unreadMessages = 0,
    required this.timeStamp,
  });

  factory Conversation.fromJson(Map<String, dynamic> map) {
    return Conversation(
        id: map["id"],
        lastMessage: map["message"],
        otherUser: map["otherUser"] ?? "",
        unreadMessages: map["unreadMessages"] ?? 0,
        target: map["target"] ?? "",
        timeStamp: DateTime.parse(map["timestamp"]),
    );
  }

  @override
  List<Object?> get props => [id];
}
