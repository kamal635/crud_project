import 'dart:io';

import 'package:crud_project/api/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  DioClient._();

  static Dio create() {
    final options = BaseOptions(
      baseUrl: Urls.base,
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 12),
      sendTimeout: const Duration(seconds: 12),
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    final dio = Dio(options);

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,

        logPrint: (object) {
          // ignore: avoid_print
          print(object);
        },
      ),
    );

    return dio;
  }
}

final dioProvider = Provider<Dio>((ref) {
  return DioClient.create();
});
