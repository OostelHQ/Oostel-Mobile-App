import 'package:my_hostel/components/hostel_info.dart';
import 'base.dart';

Future<FyndaResponse> createHostel(Map<String, dynamic> map) async {
  try {
    FormData formData = FormData.fromMap(map);
    Response response = await dio.post(
      "/hostel/create-hostel",
      data: formData,
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

Future<FyndaResponse> getHostels(Map<String, dynamic> query) async {
  try {
    Response response = await dio.get("/hostel/get-all-hostels",
        options: configuration, queryParameters: query);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Hostels Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> getHostel(String id) async {
  try {
    Response response = await dio.get(
      "/hostel/get-hostel-by-id",
      options: configuration,
      queryParameters: {
        "hostelId": id,
      }
    );

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

