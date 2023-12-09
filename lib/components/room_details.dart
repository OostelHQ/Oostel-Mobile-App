import 'package:equatable/equatable.dart';
import 'package:my_hostel/misc/functions.dart';

class RoomInfo extends Equatable {
  final String id;

  final String name;
  final List<String> facilities;
  final List<String> media;
  final double price;
  final String duration;
  final bool isRented;

  const RoomInfo({
    this.id = "",
    this.isRented = true,
    this.duration = "",
    this.facilities = const [],
    this.media = const [],
    this.price = 0.0,
    this.name = "",
  });

  @override
  List<Object?> get props => [id];

  factory RoomInfo.fromJson(Map<String, dynamic> map) {
    List<String> facilities = toStringList(map["roomFacilities"]);
    List<String> media = toStringList(map["roomPictures"]);

    return RoomInfo(
        name: map["roomNumber"],
        price: (map["price"] as num).toDouble() ,
        id: map["id"],
        duration: map["duration"],
        isRented: map["isRented"] as bool,
        facilities: facilities,
        media: media,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "facilities": facilities,
        "roomPictures": media,
      };
}


const RoomInfo noRoom = RoomInfo(id: "Empty");