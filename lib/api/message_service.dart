import 'package:my_hostel/components/conversation.dart';


import 'base.dart';
export 'base.dart' show baseEndpoint;

import 'package:my_hostel/components/message.dart';

Future<FyndaResponse<List<Message>>> getMessages(
    Map<String, String> query) async {
  try {
    Response response = await dio.get(
      "/message/get-my-chat-with-someone",
      options: configuration,
      queryParameters: query,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      // log("Messages: ${response.data}");
      List<dynamic> list = response.data["data"] as List<dynamic>;
      List<Message> messages = [];
      for (var element in list) {
        Message message = Message.fromJson(element as Map<String, dynamic>);
        messages.add(message);
      }

      messages.sort((a, b) => a.dateSent.compareTo(b.dateSent));
      return FyndaResponse(
        message: response.data["message"],
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

Future<FyndaResponse<Message?>> sendMessage(Map<String, dynamic> details) async {
  try {
    Response response = await dio.post("/message/send-message",
        data: details, options: configuration);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return FyndaResponse(
        message: response.data["message"],
        payload: Message.fromJson(response.data["data"]),
        success: true,
      );
    }
  } catch (e) {
    log("Send Messages Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<List<Conversation>>> getAllConversations(String id) async {
  try {
    Response response = await dio.get(
      "/message/get-all-receivers-with-lastChat",
      options: configuration,
      queryParameters: {"userId": id},
    );
    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      // log("Conversations: ${response.data}");
      List<dynamic> list = response.data["data"] as List<dynamic>;
      List<Conversation> conversations = [];
      for (var element in list) {
        Conversation conversation =
            Conversation.fromJson(element as Map<String, dynamic>);
        conversations.add(conversation);
      }
      return FyndaResponse(
        message: "Success",
        payload: conversations,
        success: true,
      );
    }
  } catch (e) {
    log("Get Conversations Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: [],
    success: false,
  );
}
