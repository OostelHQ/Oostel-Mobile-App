import 'package:equatable/equatable.dart';
import 'package:my_hostel/components/student.dart';

class RoommateInfo extends Equatable {
  final int level;
  final String location;
  final double amount;
  final Student student;
  final String hobby;
  final String origin;
  final String ageRange;
  final String religion;
  final bool available;

  const RoommateInfo({
    this.level = 100,
    this.location = "",
    this.amount = 0,
    this.available = false,
    required this.student,
    this.religion = "",
    this.ageRange = "",
    this.hobby = "",
    this.origin = "",
  });

  @override
  List<Object?> get props => [student.id];

  RoommateInfo.fromJson(Map<String, dynamic> map)
      : level = map["level"],
        location = map["location"],
        amount = map["amount"],
        hobby = map["hobby"],
        origin = map["origin"],
        ageRange = map["ageRange"],
        religion = map["religion"],
        student = Student.fromJson(map["student"]),
        available = map["available"];

  Map<String, dynamic> toJson() => {
        "student": student.toJson(),
        "level": level,
        "location": location,
        "amount": amount,
        "origin": origin,
        "ageRange": ageRange,
        "hobby": hobby,
        "religion": religion,
        "available": available,
      };
}
