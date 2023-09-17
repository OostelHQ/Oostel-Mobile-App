import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String image;
  final String firstName;
  final String lastName;
  final String email;

  const User({
    this.id = "",
    this.image = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
  });

  @override
  List<Object?> get props => [id];

  User.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        image = map["image"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        email = map["email"];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
}
