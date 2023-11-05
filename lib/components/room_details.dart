import 'package:equatable/equatable.dart';

class RoomInfo extends Equatable {
  final String id;

  final String name;
  final List<String> facilities;
  final List<String> media;
  final double price;

  const RoomInfo({
    this.id = "",
    this.facilities = const [],
    this.media = const [],
    this.price = 0.0,
    this.name = "",
  });

  @override
  List<Object?> get props => [id];

  RoomInfo.fromJson(Map<String, dynamic> map)
      : name = map["name"],
        price = map["price"],
        id = map["_id"],
        facilities = map["facilities"],
        media = map["media"];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "facilities": facilities,
        "media": media,
      };
}


const RoomInfo noRoom = RoomInfo(id: "Empty");