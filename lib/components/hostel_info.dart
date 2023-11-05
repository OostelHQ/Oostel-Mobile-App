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
  final String description;
  final List<String> rules;
  final List<String> hostelFacilities;
  final List<RoomInfo> rooms;
  final int totalRooms;
  final List<String> roomsLeft;
  final List<String> media;
  final List<String> likes;
  final String category;

  final Landowner owner;

  const HostelInfo({
    this.id = "",
    this.name = "",
    this.category = "",
    this.image = "",
    this.address = "",
    this.bedrooms = 0,
    this.bathrooms = 0,
    this.totalRooms = 0,
    this.area = 0.0,
    this.price = 0.0,
    this.rooms = const [],
    this.roomsLeft = const [],
    required this.owner,
    this.description = "",
    this.rules = const [],
    this.likes = const [],
    this.hostelFacilities = const [],
    this.media = const [],
  });

  @override
  List<Object?> get props => [id];


  RoomInfo roomAt(int index) {
    String id = roomsLeft[index];
    return rooms.firstWhere((room) => room.id == id, orElse: () => noRoom);
  }

  bool isAvailable(RoomInfo info) => roomsLeft.contains(info.id);
  bool isAvailableIndex(int index) => roomsLeft.contains(rooms[index].id);

  int indexAt(int index) {
    String id = roomsLeft[index];
    for(int i = 0; i < rooms.length; ++i) {
      if(rooms[i].id == id) return i;
    }
    return -1;
  }

  factory HostelInfo.fromJson(Map<String, dynamic> map) => HostelInfo(
        id: map["_id"],
        name: map["name"],
        image: map["image"],
        bedrooms: map["bedrooms"],
        bathrooms: map["bathrooms"],
        area: map["area"],
        price: map["price"],
        totalRooms: map["totalRooms"],
        address: map["address"],
        category: map["category"],
        roomsLeft: map["roomsLeft"],
        description: map["description"],
        rules: map["rules"],
        likes: map["likes"],
        hostelFacilities: map["hostelFacilities"],
        media: map["media"],
        owner: Landowner.fromJson(map["owner"]),
      );
}
