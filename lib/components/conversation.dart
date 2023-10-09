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
        id: map["_id"],
        lastMessage: map["lastMessage"],
        otherUser: map["otherUser"],
        unreadMessages: map["unreadMessages"],
        target: map["target"],
        timeStamp: DateTime.parse(map["createdAt"]),
    );
  }

  @override
  List<Object?> get props => [id];
}
