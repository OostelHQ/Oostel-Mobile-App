import 'package:equatable/equatable.dart';

class RoommateInfo extends Equatable {
  final String id;

  const RoommateInfo({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
