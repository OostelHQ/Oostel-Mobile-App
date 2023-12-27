import 'package:equatable/equatable.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/api/file_manager.dart' show SingleFileResponse;

import 'dart:developer' show log;

class HostelInfo extends Equatable {
  final String id;
  final String name;
  final String address;
  final double area;
  final double price;
  final String description;
  final List<String> rules;
  final List<String> hostelFacilities;
  final List<RoomInfo> rooms;
  final int totalRooms;
  final List<String> roomsLeft;
  final List<String> media;
  final int likes;
  final String category;
  final bool vacantRooms;
  final String owner;

  const HostelInfo({
    this.id = "",
    this.name = "",
    this.category = "",
    this.address = "",
    this.totalRooms = 0,
    this.area = 0.0,
    this.price = 0.0,
    this.vacantRooms = false,
    this.rooms = const [],
    this.roomsLeft = const [],
    required this.owner,
    this.description = "",
    this.rules = const [],
    this.likes = 0,
    this.hostelFacilities = const [],
    this.media = const [],
  });

  @override
  List<Object?> get props => [id];

  HostelInfoData get data => HostelInfoData.fromInfo(this);

  // List<double> get priceRange {
  //   List<String> values = price.split(" ");
  //   return [double.parse(values[0]), double.parse(values[2])];
  // }

  RoomInfo roomAt(int index) {
    String id = roomsLeft[index];
    return rooms.firstWhere((room) => room.id == id, orElse: () => noRoom);
  }

  bool isAvailable(RoomInfo info) => roomsLeft.contains(info.id);

  bool isAvailableIndex(int index) => roomsLeft.contains(rooms[index].id);

  int indexAt(int index) {
    String id = rooms[index].id;
    for (int i = 0; i < rooms.length; ++i) {
      if (rooms[i].id == id) return i;
    }
    return -1;
  }

  factory HostelInfo.fromJson(Map<String, dynamic> map) {
    String street = map["street"] ?? "",
        junction = map["junction"] ?? "",
        state = map["state"] ?? "",
        country = map["country"] ?? "";

    return HostelInfo(
      id: map["hostelId"],
      name: map["hostelName"],
      area: (map["homeSize"] as num).toDouble(),
      price: map["price"] ?? 0.0,
      totalRooms: map["totalRoom"] ?? 0,
      address: "$street#$junction#$state#$country",
      category: map["hostelCategory"],
      roomsLeft: map["roomsLeft"] ?? [],
      description: map["hostelDescription"],
      rules: map["rulesAndRegulation"],
      likes: map["hostelLikesCount"] ?? 0,
      hostelFacilities: map["hostelFacilities"],
      media: map["media"] ?? [],
      owner: map["userId"] ?? "",
      rooms: map["rooms"] ?? [],
      vacantRooms: map["isAnyRoomVacant"] ?? false,
    );
  }
}

class HostelInfoData {
  final String id;
  final String owner;

  String name;
  String address;
  double area;
  double price;
  String description;
  List<String> rules;
  List<String> hostelFacilities;
  List<RoomInfoData> rooms;
  int totalRooms;
  List<dynamic> media;
  int likes;
  int category;
  bool vacantRooms;

  int? roomEditIndex;

  HostelInfoData({
    required this.id,
    required this.owner,
    this.name = "",
    this.category = 0,
    this.address = "",
    this.totalRooms = 0,
    this.area = 0.0,
    this.price = 0.0,
    this.vacantRooms = false,
    this.rooms = const [],
    this.description = "",
    this.rules = const [],
    this.likes = 0,
    this.hostelFacilities = const [],
    this.media = const [],
    this.roomEditIndex,
  });

  bool isLocal(int index) => media[index] !is String;

  factory HostelInfoData.fromInfo(HostelInfo info) {
    int category = 0;
    // switch(info.category) {
    //
    // }

    List<RoomInfoData> roomData = [];
    for(RoomInfo info in info.rooms) {
      roomData.add(RoomInfoData.fromRoom(info));
    }

    return HostelInfoData(
      owner: info.owner,
      id: info.id,
      name: info.name,
      description: info.description,
      category: category,
      address: info.address,
      price: info.price,
      area: info.area,
      media: List.from(info.media),
      hostelFacilities: List.from(info.hostelFacilities),
      likes: info.likes,
      rooms: roomData,
      rules: List.from(info.rules),
      totalRooms: info.totalRooms,
      vacantRooms: info.vacantRooms,
    );
  }
}
