import 'dart:io';

import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'base.dart';

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
    List<RoomInfo> rooms = _toRoomList(map["rooms"]);
    for (String facility in facilities) {
      formData.fields.addAll([MapEntry("FacilityName", facility)]);
    }
    for (String rule in rules) {
      formData.fields.addAll([MapEntry("RuleAndRegulation", rule)]);
    }
    //for(RoomInfo info in rooms) {
    formData.fields.addAll(const [MapEntry("rooms", "{}")]);
    //}

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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

Future<FyndaResponse<List<HostelInfo>>> getAllHostels(Map<String, dynamic> query) async {
  try {
    Response response = await dio.get("/hostel/get-all-hostels",
        options: configuration, queryParameters: query);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      //log(response.data.length.toString());
      log(response.data[8].toString());
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

Future<FyndaResponse> getHostel(String id) async {
  try {
    Response response = await dio.get("/hostel/get-hostel-by-id",
        options: configuration,
        queryParameters: {
          "hostelId": id,
        });

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

Future<FyndaResponse> createRoomForHostel(Map<String, dynamic> map) async {
  try {
    FormData formData = FormData.fromMap(map);
    Response response = await dio.post(
      "/hostel/create-room-for-hostel",
      data: formData,
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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
