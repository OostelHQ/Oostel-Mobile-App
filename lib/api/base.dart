import 'package:dio/dio.dart';
export 'package:dio/dio.dart';

import 'dart:developer' show log;
export 'dart:developer' show log;

const String baseEndpoint = "https://fyndaapp-001-site1.atempurl.com";
const String baseUrl = "$baseEndpoint/api";

final Dio dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 180),
    receiveTimeout: const Duration(seconds: 180),
  ),
);

void initBase() {
  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions options, RequestInterceptorHandler handler) async {
    log("Request: ${options.method} ${options.path}");
    handler.next(options);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) async {
    log("Response: ${response.statusCode} ${response.data}");
    handler.next(response);
  }, onError: (DioException e, ErrorInterceptorHandler handler) async {
    log("Error: ${e.message}");
    handler.next(e);
  }));
}

String token = "";

Options get configuration => Options(headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    },
);

  class FyndaResponse<T> {
    final String message;
    final T payload;
    final bool success;

    const FyndaResponse({
      required this.message,
      required this.payload,
      required this.success,
    });
  }
