import 'package:my_hostel/components/user.dart';
import 'base.dart';

Future<FyndaResponse> getMessages(Map<String, dynamic> map) async {
  try {
    Response response =
        await dio.get("/message/get-user-message", queryParameters: map, options: configuration);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return FyndaResponse(
          message: response.data["message"], payload: null, success: true);
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

Future<FyndaResponse> deleteMessage(String ID) async {
  try {
    Response response = await dio
        .delete("/message/delete-message", queryParameters: {"messageId": ID}, options: configuration);

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
