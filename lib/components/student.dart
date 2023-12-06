import 'package:my_hostel/components/user.dart';

class Student extends User {

  final int level;
  final String location;
  final double amount;
  final String hobby;
  final String origin;
  final String guardian;
  final String ageRange;
  final bool available;
  final String address;

  const Student({
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
    this.level = 0,
    this.location = "",
    this.guardian = "",
    this.amount = 0,
    this.available = false,
    this.ageRange = "",
    this.hobby = "",
    this.origin = "",
    this.address = ""
  }) : super(
    type: UserType.student,
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
          score += 5;
        }

        score += 5;
      } else {
        score += 10;
      }
    }

    if(level != 0) {
      score += 5;
    }

    if(ageRange.isNotEmpty) {
      score += 5;
    }

    if(address.isNotEmpty) {
      score += 10;
    }

    if(location.isNotEmpty) {
      score += 10;
    }

    if(guardian.isNotEmpty) {
      score += 5;
    }
    
    if(origin.isNotEmpty) {
      score += 5;
    }

    if(hobby.isNotEmpty) {
      score += 10;
    }

    return score;
  }


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
        address: map["address"],
        ageRange: map["ageRange"],
        religion: map["religion"],
        denomination: map["denomination"],
        available: map["available"],
        dateJoined: DateTime.parse(map["createdAt"]),
        level: map["level"],
      );
}
