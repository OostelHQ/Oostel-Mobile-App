import 'package:my_hostel/components/user.dart';

class Agent extends User {
  final DateTime dob;
  final String address;

  
  const Agent({
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

    this.address = "",
    required this.dob,
  }) : super(
    type: UserType.agent,
  );

  @override
  List<Object?> get props => [id];

  factory Agent.fromJson(Map<String, dynamic> map) {
    String address = "${map["street"] ?? ""}#${map["state"] ?? ""}#${map["country"] ?? ""}";
    return Agent(
      id: map["_id"],
      image: map["image"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      email: map["email"],
      gender: map["gender"],
      contact: map["phoneNumber"],
      address: address,
      religion: map["religion"],
      // denomination: map["denomination"],
      // profileViews: map["profileViews"],
      // searchAppearances: map["searchAppearances"],
      dateJoined: DateTime.parse(map["createdAt"]),
      dob: DateTime.parse(map["dateOfBirth"]),
    );
  }
}