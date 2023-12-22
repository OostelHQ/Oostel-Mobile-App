import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/functions.dart';
import 'base.dart';

export 'base.dart';

List<RoomInfo> _toRoomList(List<dynamic> list) {
  List<RoomInfo> result = [];
  for (var element in list) {
    result.add(element as RoomInfo);
  }
  return result;
}

Future<FyndaResponse> createHostel(Map<String, dynamic> map) async {
  try {
    FormData formData = FormData();
    List<SingleFileResponse> medias = map["medias"];
    for (SingleFileResponse response in medias) {
      if (response.extension == "mp4") {
        formData.files.addAll([
          MapEntry("videoUrl", await MultipartFile.fromFile(response.path))
        ]);
      } else {
        formData.files.addAll([
          MapEntry("hostelFrontViewPicture",
              await MultipartFile.fromFile(response.path))
        ]);
      }
    }

    List<String> facilities = map["FacilityName"],
        rules = map["RuleAndRegulation"];
    for (String facility in facilities) {
      formData.fields.addAll([MapEntry("FacilityName", facility)]);
    }
    for (String rule in rules) {
      formData.fields.addAll([MapEntry("RuleAndRegulation", rule)]);
    }
    formData.fields.addAll(const [MapEntry("rooms", "{}")]);

    String budget = "${map["minPrice"]} - ${map["maxPrice"]}";

    formData.fields.add(MapEntry("landlordId", map["landlordId"]));
    formData.fields
        .add(MapEntry("hostelDescription", map["hostelDescription"]));
    formData.fields.add(MapEntry("hostelName", map["hostelName"]));
    formData.fields.add(MapEntry("street", map["street"]));
    formData.fields.add(MapEntry("junction", map["junction"]));
    formData.fields.add(MapEntry("state", map["state"]));
    formData.fields.add(MapEntry("country", map["country"]));
    formData.fields.add(MapEntry("priceBudgetRange", budget));
    formData.fields
        .add(MapEntry("homeSize", map["homeSize"].toStringAsFixed(0)));
    formData.fields
        .add(MapEntry("hostelCategory", map["hostelCategory"].toString()));
    formData.fields.add(MapEntry("totalRoom", map["totalRoom"].toString()));
    formData.fields
        .add(MapEntry("isAnyRoomVacant", map["isAnyRoomVacant"].toString()));


    Response response = await dio.post(
      "/hostel/create-hostel",
      data: formData,
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
        message: "Hostel Created",
        payload: null,
        success: true,
      );
    }
  } catch (e) {
    log("Create Hostel Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> updateHostel(Map<String, dynamic> map) async {
  try {
    FormData formData = FormData.fromMap(map);
    Response response = await dio.post(
      "/hostel/update-hostel",
      data: formData,
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Update Hostel Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<List<HostelInfo>>> getAllHostels(
    Map<String, dynamic> query) async {
  try {
    Response response = await dio.get("/hostel/get-all-hostels",
        options: configuration, queryParameters: query);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      List<dynamic> list = response.data as List<dynamic>;
      List<HostelInfo> hostels = [];
      for (var element in list) {
        HostelInfo info = _parseHostelData(element);
        hostels.add(info);
      }

      return FyndaResponse(
        message: "Success",
        payload: hostels,
        success: true,
      );
    }
  } catch (e) {
    log("Get Hostels Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: [],
    success: false,
  );
}

HostelInfo _parseHostelData(Map<String, dynamic> element, {String? id }) {
  List<String> rules =
  toStringList(element["rulesAndRegulation"] as List<dynamic>);
  List<String> facilities =
  toStringList(element["hostelFacilities"] as List<dynamic>);
  List<String> media =
  toStringList(element["hostelFrontViewPicture"] as List<dynamic>);
  List<RoomInfo> rooms = (element['rooms'] == null) ? [] : parseRoomData(element['rooms'] as List<dynamic>);
  element['rooms'] = rooms;

  element["rulesAndRegulation"] = rules;
  element["hostelFacilities"] = facilities;
  element["media"] = media;

  element["userId"] = element['userId'] ?? id;
  HostelInfo info = HostelInfo.fromJson(element);
  return info;
}

Future<FyndaResponse<Map<String, dynamic>?>> getHostel(String id) async {
  try {
    Response response = await dio.get("/hostel/get-hostel-by-id",
        options: configuration,
        queryParameters: {
          "hostelId": id,
        });

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      Map<String, dynamic> map = response.data["data"];

      List<RoomInfo> rooms = parseRoomData(map["rooms"] as List<dynamic>);
      map["rooms"] = rooms;

      Landowner owner = parseLandlordData(map, fromHostel: true);
      map["owner"] = owner;

      return FyndaResponse(
        message: "Success",
        payload: map,
        success: true,
      );
    }
  } catch (e) {
    log("Get Hostel By ID Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<List<HostelInfo>?>> getAllHostelsForLandlord(String id) async {
  try {
    Response response = await dio.get("/hostel/get-my-hostels",
        options: configuration,
        queryParameters: {
          "landlordId": id,
        });

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      List<dynamic> list = response.data['data'] as List<dynamic>;
      List<HostelInfo> hostels = [];
      for (var element in list) {
        HostelInfo info = _parseHostelData(element, id: id);
        hostels.add(info);
      }

      return FyndaResponse(
        message: "Success",
        payload: hostels,
        success: true,
      );
    }
  } catch (e) {
    log("Get Hostels For Landlord Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}


Future<FyndaResponse> createRoomForHostel({
  required String userID,
  required String hostelID,
  required Map<String, dynamic> map,
}) async {
  FormData formData = FormData();
  formData.fields.add(MapEntry("UserId", userID));
  formData.fields.add(MapEntry("HostelId", hostelID));
  formData.fields.add(MapEntry("RoomNumber", map["name"]));
  formData.fields.add(MapEntry("Duration", map["duration"]));
  formData.fields.add(MapEntry("Price", map["price"].toStringAsFixed(0)));
  for (String facility in map["facilities"]) {
    formData.fields.addAll([MapEntry("RoomFacilities", facility)]);
  }
  formData.fields.add(const MapEntry("isRented", "true"));
  List<SingleFileResponse> medias = map["medias"];
  for (SingleFileResponse response in medias) {
    formData.files.addAll(
        [MapEntry("Files", await MultipartFile.fromFile(response.path))]);
  }

  try {
    Response response = await dio.post(
      "/hostel/create-room-for-hostel",
      data: formData,
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
        message: "Success",
        payload: null,
        success: true,
      );
    }
  } catch (e) {
    log("Create Room Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> updateRoomForHostel(Map<String, dynamic> map) async {
  try {
    FormData formData = FormData.fromMap(map);
    Response response = await dio.put(
      "/hostel/update-room",
      data: formData,
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Update Room Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> getRoomFromHostel(Map<String, dynamic> map) async {
  try {
    Response response = await dio.get(
      "/hostel/get-a-room-for-hostel",
      options: configuration,
      queryParameters: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Room From Hostel Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> getAllRoomsFromHostel(Map<String, dynamic> map) async {
  try {
    Response response = await dio.get(
      "/hostel/get-all-rooms-for-hostel",
      options: configuration,
      queryParameters: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get All Rooms From Hostel Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> likeHostel(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/hostel/add-hostel-likes",
      options: configuration,
      queryParameters: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Like Hostel Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<List<String>>> getStudentLikedHostels(String studentId) async {
  try {
    Response response = await dio.get(
      "/hostel/get-my-liked-hostels",
      options: configuration,
      queryParameters: {"userId": studentId},
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch(e) {
    log("Get Student Liked Hostels Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: [],
    success: false,
  );
}


Future<FyndaResponse> getHostelLikedUsers(String hostelId) async {
  try {
    Response response = await dio.get(
      "/hostel/hostel-liked-users",
      options: configuration,
      queryParameters: {"hostelId": hostelId},
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch(e) {
    log("Get Hostel Liked Users Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: [],
    success: false,
  );
}

List<RoomInfo> parseRoomData(List<dynamic> data) {
  List<RoomInfo> rooms = [];
  for (var element in data) {
    RoomInfo info = RoomInfo.fromJson(element as Map<String, dynamic>);
    rooms.add(info);
  }
  return rooms;
}
