import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String image;
  final String firstName;
  final String lastName;
  final String email;
  final String contact;
  final String religion;
  final String gender;
  final String denomination;
  final DateTime dateJoined;
  final int profileViews;
  final int searchAppearances;

  const User({
    this.id = "",
    this.image = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.gender = "",
    this.contact = "",
    this.religion = "",
    this.denomination = "",
    required this.dateJoined,
    this.profileViews = 0,
    this.searchAppearances = 0,
  });

  String get mergedNames => "$lastName $firstName";

  @override
  List<Object?> get props => [id];
}
