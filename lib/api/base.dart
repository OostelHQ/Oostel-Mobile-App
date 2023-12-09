import 'package:dio/dio.dart';
export 'package:dio/dio.dart';

import 'package:signalr_flutter/signalr_flutter.dart';

export 'dart:developer' show log;

const String baseUrl = "http://fyndaapp-001-site1.htempurl.com/api";

final Dio dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 180),
  ),
);

String token = "";

Options get configuration => Options(headers: {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer $token"
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
