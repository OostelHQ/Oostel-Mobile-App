import 'package:signalr_flutter/signalr_api.dart';
import 'package:signalr_flutter/signalr_flutter.dart';
import 'base.dart';
import 'package:signalr_netcore/signalr_client.dart';

Future<FyndaResponse> getMessages() async {
  final SignalR socket = SignalR(
      "http://fyndaapp-001-site1.htempurl.com/hubs", "message",
      hubMethods: [
        "get-user-messages",
        'delete-message'
      ],
      headers: {
        "Authorization": "Bearer $token",
      }, statusChangeCallback: (status) {
    log("Status: $status");
  }, hubCallback: (methodName, message) {
    log(methodName);
    log(message);
  });

// The location of the SignalR Server.
//   const serverUrl = "http://fyndaapp-001-site1.htempurl.com/hubs/message";
//   final connectionOptions = HttpConnectionOptions(
//     transport: HttpTransportType.WebSockets,
//     accessTokenFactory: () async => token,
//   );
// // Creates the connection by using the HubConnectionBuilder.
//   final hubConnection = HubConnectionBuilder()
//       .withUrl(
//         serverUrl,
//         options: connectionOptions,
//         // transportTyp: HttpTransportType.WebSockets,
//       )
//       .build();
// When the connection is closed, print out a message to the console.

  // hubConnection.onclose((error) => log("Connection Closed: $error"));

  try {
    socket.connect();
    // await hubConnection.start();
    // hubConnection.on("connect", (val) {log("Connected");});

    //final result = await hubConnection.invoke("MethodOneSimpleParameterSimpleReturnValue", args: <Object>["ParameterValue"]);

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
