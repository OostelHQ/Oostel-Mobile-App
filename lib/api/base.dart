import 'package:dio/dio.dart';
export 'package:dio/dio.dart';

export 'dart:developer' show log;

final Dio dio = Dio(
  BaseOptions(
    baseUrl: "http://fyndaapp-001-site1.htempurl.com/api",
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 120),
  ),
);

String token = "";

final Options configuration = Options(headers: {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer ${token}"
});

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
