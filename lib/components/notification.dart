import 'package:equatable/equatable.dart';
import 'package:my_hostel/components/user.dart';

class NotificationData extends Equatable {
  final String id;
  final User sender;
  final String message;
  final DateTime timestamp;

  const NotificationData({
    this.id = "",
    required this.sender,
    this.message = "",
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id];

  NotificationData.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        sender = User.fromJson(map["sender"]),
        timestamp = DateTime.parse(map["createdAt"]),
        message = map["message"];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdAt": timestamp.toString(),
        "sender": sender.toJson(),
        "message": message,
      };
}
