import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String image;
  final String firstName;
  final String lastName;
  final String email;

  const Student({
    required this.id,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "firstName": firstName,
        "lastName": lastName,
        "email": email
      };

  Student.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        image = map["image"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        email = map["email"];
}
