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
    required this.dateJoined,
  });

  @override
  List<Object?> get props => [id];

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
        dateJoined = DateTime.parse(map["createdAt"]);

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
        "address": address,
        "createdAt": dateJoined.toString(),
        "totalRated": totalRated,
      };
}
