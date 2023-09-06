import 'package:equatable/equatable.dart';

class HostelInfo extends Equatable {
  final String id;
  final String name;
  final String image;

  const HostelInfo({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id];

  HostelInfo.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        name = map["name"],
        image = map["image"];

  Map<String, dynamic> toJson() => {
    "_id" : id,
    "name" : name,
    "image" : image,
  };
}
