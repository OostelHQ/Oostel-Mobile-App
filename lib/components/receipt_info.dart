import 'package:equatable/equatable.dart';

class Receipt extends Equatable {
  final String id;
  final String studentName;
  final String amountInWords;
  final String landOwnerName;
  final String hostel;
  final String reference;
  final DateTime timestamp;

  const Receipt({
    this.id = "",
    this.studentName = "",
    this.amountInWords = "",
    this.landOwnerName = "",
    this.hostel = "",
    this.reference = "",
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdAt": timestamp.toString(),
        "studentName": studentName,
        "landOwnerName": landOwnerName,
        "hostel": hostel,
        "reference": reference,
        "amountInWords": amountInWords,
      };

  Receipt.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        timestamp = DateTime.parse(map["createdAt"]),
        studentName = map["studentName"],
        landOwnerName = map["landOwnerName"],
        amountInWords = map["amountInWords"],
        reference = map["reference"],
        hostel = map["hostel"];
}
