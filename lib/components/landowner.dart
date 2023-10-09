import 'package:my_hostel/components/user.dart';

class Landowner extends User {
  final bool verified;
  final String address;
  final double ratings;
  final int totalRated;
  final DateTime dob;

  const Landowner({
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
    this.verified = false,
    this.ratings = 0.0,
    this.totalRated = 0,
    this.address = "",
    required this.dob,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          image: image,
          contact: contact,
          religion: religion,
          gender: gender,
          dateJoined: dateJoined,
          profileViews: profileViews,
          searchAppearances: searchAppearances,
          denomination: denomination,
        );

  @override
  List<Object?> get props => [id];

  String get mergedNames => "$firstName $lastName";

  factory Landowner.fromJson(Map<String, dynamic> map) => Landowner(
        id: map["_id"],
        image: map["image"],
        firstName: map["firstName"],
        lastName: map["lastName"],
        verified: map["verified"],
        ratings: map["ratings"],
        email: map["email"],
        gender: map["gender"],
        totalRated: map["totalRated"],
        contact: map["contact"],
        address: map["address"],
        religion: map["religion"],
        denomination: map["denomination"],
        profileViews: map["profileViews"],
        searchAppearances: map["searchAppearances"],
        dateJoined: DateTime.parse(map["createdAt"]),
        dob: DateTime.parse(map["dob"]),
      );
}
