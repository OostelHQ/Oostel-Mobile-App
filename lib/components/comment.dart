import 'package:equatable/equatable.dart';
import 'package:my_hostel/components/student.dart';

class Comment extends Equatable {
  final String id;
  final double ratings;
  final String header;
  final String subtitle;
  final Student postedBy;
  final DateTime postTime;

  const Comment({
    this.id = "",
    this.ratings = 3.5,
    this.header = "",
    this.subtitle = "",
    required this.postedBy,
    required this.postTime,
  });

  @override
  List<Object?> get props => [id];
}
