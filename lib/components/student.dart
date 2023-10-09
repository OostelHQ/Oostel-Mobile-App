import 'package:equatable/equatable.dart';
import 'package:my_hostel/components/user.dart';

class Student extends User {

  final int level;
  final String location;
  final double amount;
  final String hobby;
  final String origin;
  final String ageRange;
  final bool available;

  const Student({
    String id = "",
    String image = "",
    String firstName = "",
    String lastName = "",
    String gender = "",
    String email = "",
    String contact = "",
    String religion = "",
    String denomination = "",
    int profileViews = 0,
    int searchAppearances = 0,
    required DateTime dateJoined,
    this.level = 100,
    this.location = "",
    this.amount = 0,
    this.available = false,
    this.ageRange = "",
    this.hobby = "",
    this.origin = "",
  }) : super(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    image: image,
    contact: contact,
    gender: gender,
    religion: religion,
    dateJoined: dateJoined,
    profileViews: profileViews,
    searchAppearances: searchAppearances,
    denomination: denomination,
  );


  @override
  List<Object?> get props => [id];


  factory Student.fromJson(Map<String, dynamic> map) =>
      Student(
        id: map["_id"],
        image: map["image"],
        profileViews: map["profileViews"],
        searchAppearances: map["searchAppearances"],
        firstName: map["firstName"],
        lastName: map["lastName"],
        email: map["email"],
        gender: map["gender"],
        location: map["location"],
        amount: map["amount"],
        hobby: map["hobby"],
        contact: map["contact"],
        origin: map["origin"],
        ageRange: map["ageRange"],
        religion: map["religion"],
        denomination: map["denomination"],
        available: map["available"],
        dateJoined: DateTime.parse(map["createdAt"]),
        level: map["level"],
      );
}
