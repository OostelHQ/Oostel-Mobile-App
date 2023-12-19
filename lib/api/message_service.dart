import 'package:my_hostel/api/socket_service.dart';
export 'package:my_hostel/api/socket_service.dart';

import 'base.dart';


Future<FyndaResponse> getMessages() async {

  try {
    Response response = await dio.get("/message/get-user-messages");
    if(response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());


    }


  } catch (e) {
    log("Get Messages Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> deleteMessage(String id) async {
  try {
    Response response = await dio.delete("/message/delete-message",
        queryParameters: {"messageId": id}, options: configuration);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return FyndaResponse(
        message: response.data["message"],
        payload: null,
        success: true,
      );
    }
  } catch (e) {
    log("Delete Messages Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}
