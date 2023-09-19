import 'package:equatable/equatable.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/room_details.dart';

class HostelInfo extends Equatable {
  final String id;
  final String name;
  final String address;
  final String image;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final double price;
  final int totalRooms;
  final String description;
  final List<String> rules;
  final List<String> hostelFacilities;
  final List<RoomInfo> roomsLeft;
  final List<String> media;

  final Landowner owner;

  const HostelInfo({
    this.id = "",
    this.name = "",
    this.image = "",
    this.address = "",
    this.bedrooms = 0,
    this.bathrooms = 0,
    this.area = 0.0,
    this.price = 0.0,
    this.totalRooms = 0,
    this.roomsLeft = const [],
    required this.owner,
    this.description = "",
    this.rules = const [],
    this.hostelFacilities = const [],
    this.media = const [],
  });

  @override
  List<Object?> get props => [id];

  HostelInfo.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        name = map["name"],
        image = map["image"],
        bedrooms = map["bedrooms"],
        bathrooms = map["bathrooms"],
        area = map["area"],
        price = map["price"],
        address = map["address"],
        roomsLeft = map["roomsLeft"],
        description = map["description"],
        rules = map["rules"],
  totalRooms = map["totalRooms"],
        hostelFacilities = map["hostelFacilities"],
        media = map["media"],
        owner = Landowner.fromJson(map["owner"]);

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> jsonRooms = [];
    for(RoomInfo info in roomsLeft) {
      jsonRooms.add(info.toJson());
    }

    return {
      "_id": id,
      "name": name,
      "image": image,
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "area": area,
      "address": address,
      "price": price,
      "rules": rules,
      "totalRooms" : totalRooms,
      "description": description,
      "roomsLeft": jsonRooms,
      "hostelFacilities": hostelFacilities,
      "media" : media,
      "owner": owner.toJson(),
    };
  }
}
