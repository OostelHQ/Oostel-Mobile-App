import 'package:my_hostel/components/user.dart';

class Landowner extends User {
  final bool verified;
  final String address;
  final double ratings;
  final int totalRated;
  final DateTime dob;

  const Landowner({
    super.id,
    super.image,
    super.firstName,
    super.lastName,
    super.gender,
    super.email,
    super.contact,
    super.religion,
    super.denomination,
    super.profileViews,
    super.searchAppearances,
    required super.dateJoined,
    this.verified = false,
    this.ratings = 0.0,
    this.totalRated = 0,
    this.address = "",
    required this.dob,
  }) : super(
          type: UserType.landlord,
        );

  @override
  List<Object?> get props => [id];

  @override
  int get hasCompletedProfile {
    int score = 20;

    if(image.isNotEmpty) {
      score += 10;
    }

    if(gender.isNotEmpty) {
      score += 5;
    }

    if(contact.isNotEmpty ) {
      score += 5;
    }

    if(religion.isNotEmpty) {
      if(religion == "Christianity") {
        if(denomination.isNotEmpty) {
          score += 10;
        }

        score += 10;
      } else {
        score += 20;
      }
    }

    if(address.isNotEmpty) {
      score += 40;
    }

    return score;
  }


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
