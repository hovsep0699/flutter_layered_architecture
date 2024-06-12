import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Config {
  static const String baseURL = "https://score-up.velox.am/";
  static const String login = "api/user/login";

  static final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 60000),
      baseUrl: baseURL);

  static final Dio dio = Dio(options)
    ..interceptors.add(
      LogInterceptor(
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );
}
