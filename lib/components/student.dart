import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String image;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;

  const Student({
    this.id = "",
    this.image = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.gender = "",
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
      };

  Student.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        image = map["image"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        email = map["email"],
        gender = map["gender"];
}
