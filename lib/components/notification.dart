import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  final String id;
  final String image;
  final String message;
  final DateTime timestamp;

  const NotificationData({
    this.id = "",
    this.image = "",
    this.message = "",
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id];

  factory NotificationData.fromJson(Map<String, dynamic> map) =>
      NotificationData(
        id: map["_id"],
        image: map["image"],
        timestamp: DateTime.parse(map["createdAt"]),
        message: map["message"],
      );
}
