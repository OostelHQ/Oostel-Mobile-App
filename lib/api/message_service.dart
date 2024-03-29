import 'package:my_hostel/api/socket_service.dart';
export 'package:my_hostel/api/socket_service.dart';

import 'base.dart';
export 'base.dart' show baseEndpoint;

import 'package:my_hostel/components/message.dart';

Future<FyndaResponse<List<Message>>> getMessages(String email) async {
  try {
    Response response = await dio.get(
      "/message/get-user-messages",
      options: configuration,
      queryParameters: {"Email": email},
    );
    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log("Messages: ${response.data}");
      List<dynamic> list = response.data as List<dynamic>;
      List<Message> messages = [];
      for (var element in list) {
        Message message = Message.fromJson(element as Map<String, dynamic>);
        messages.add(message);
      }
      return FyndaResponse(
        message: "Success",
        payload: messages,
        success: true,
      );
    }
  } catch (e) {
    log("Get Messages Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: [],
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
