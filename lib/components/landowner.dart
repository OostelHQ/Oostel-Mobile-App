import 'package:equatable/equatable.dart';

class Landowner extends Equatable {
  final String id;
  final String image;
  final String gender;
  final String firstName;
  final String lastName;
  final bool verified;
  final String address;
  final double ratings;
  final int totalRated;
  final String contact;
  final String email;
  final DateTime dateJoined;
  final DateTime dob;

  final String religion;
  final String denomination;

  final int profileViews;
  final int searchAppearances;

  const Landowner({
    this.id = "",
    this.image = "",
    this.firstName = "",
    this.lastName = "",
    this.gender = "",
    this.verified = false,
    this.ratings = 0.0,
    this.totalRated = 0,
    this.email = "",
    this.contact = "",
    this.address = "",
    this.religion = "",
    this.denomination = "",
    required this.dob,
    required this.dateJoined,
    this.profileViews = 0,
    this.searchAppearances = 0,
  });

  @override
  List<Object?> get props => [id];

  String get mergedNames => "$firstName $lastName";

  Landowner.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        image = map["image"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        verified = map["verified"],
        ratings = map["ratings"],
        email = map["email"],
        gender = map["gender"],
        totalRated = map["totalRated"],
        contact = map["contact"],
        address = map["address"],
        religion = map["religion"],
        denomination = map["denomination"],
        profileViews = map["profileViews"],
        searchAppearances = map["searchAppearances"],
        dateJoined = DateTime.parse(map["createdAt"]),
        dob = DateTime.parse(map["dob"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "firstName": firstName,
        "lastName": lastName,
        "verified": verified,
        "ratings": ratings,
        "gender": gender,
        "contact": contact,
        "email": email,
        "dob": dob.toString(),
        "religion": religion,
        "denomination": denomination,
        "profileViews": profileViews,
        "searchAppearances": searchAppearances,
        "address": address,
        "createdAt": dateJoined.toString(),
        "totalRated": totalRated,
      };
}
