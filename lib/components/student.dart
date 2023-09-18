import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String image;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String contact;

  final int level;
  final String location;
  final double amount;
  final String hobby;
  final String origin;
  final String ageRange;
  final String religion;
  final String denomination;
  final bool available;

  final DateTime joined;
  final int rentedHostels;
  final int collaboratedRoommates;

  final int profileViews;
  final int searchAppearances;

  const Student({
    this.id = "",
    this.image = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.gender = "",
    this.contact = "",
    this.level = 100,
    this.location = "",
    this.amount = 0,
    this.available = false,
    this.religion = "",
    this.ageRange = "",
    this.hobby = "",
    this.origin = "",
    this.denomination = "",
    this.rentedHostels = 0,
    this.collaboratedRoommates = 0,
    this.profileViews = 0,
    this.searchAppearances = 0,
    required this.joined,
  });

  @override
  List<Object?> get props => [id];

  String get mergedNames => "$lastName $firstName";

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "gender": gender,
        "level": level,
        "location": location,
        "amount": amount,
        "origin": origin,
        "contact": contact,
        "ageRange": ageRange,
        "hobby": hobby,
        "religion": religion,
        "denomination": denomination,
        "available": available,
        "rentedHostels": rentedHostels,
        "collaboratedRoommates": collaboratedRoommates,
        "createdAt": joined.toString(),
        "profileViews": profileViews,
        "searchAppearances": searchAppearances,
      };

  Student.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        image = map["image"],
        profileViews = map["profileViews"],
        searchAppearances = map["searchAppearances"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        email = map["email"],
        gender = map["gender"],
        location = map["location"],
        amount = map["amount"],
        hobby = map["hobby"],
        contact = map["contact"],
        origin = map["origin"],
        ageRange = map["ageRange"],
        religion = map["religion"],
        denomination = map["denomination"],
        collaboratedRoommates = map["collaboratedRoommates"],
        rentedHostels = map["rentedHostels"],
        available = map["available"],
        joined = DateTime.parse(map["createdAt"]),
        level = map["level"];
}
