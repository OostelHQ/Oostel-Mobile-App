import 'package:signalr_flutter/signalr_flutter.dart';

import 'base.dart';

Future<FyndaResponse> getMessages() async {


  final SignalR socket = SignalR("http://fyndaapp-001-site1.htempurl.com/hubs", "/message",
      hubMethods: ["POST"],
      statusChangeCallback: (status) {},
      hubCallback: (methodName, message) {
          log(methodName);
          log(message);
      }
  );




  try {
    socket.connect();

    // Response response = await dio.get("/message/get-user-message",
    //     queryParameters: map, options: configuration);
    //
    // if (response.statusCode! >= 200 && response.statusCode! < 400) {
    //   return FyndaResponse(
    //       message: response.data["message"], payload: null, success: true);
    // }
  } catch (e) {
    log("Get Messages Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> deleteMessage(String ID) async {
  try {
    Response response = await dio.delete("/message/delete-message",
        queryParameters: {"messageId": ID}, options: configuration);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return FyndaResponse(
          message: response.data["message"], payload: null, success: true);
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

