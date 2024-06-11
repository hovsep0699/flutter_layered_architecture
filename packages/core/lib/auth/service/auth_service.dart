import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ApiUserResType = Response<dynamic>;

class AuthService {
  String? baseUrl;
  String? _token;
  final Dio _dio = Config.dio;
  AuthService({required this.baseUrl});

  bool get isAuthorized => _token != null;
  // bool get isExpired => _token == null || JwtDecoder.isExpired(_token!);

  Future<void> saveToPrefs(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString('access_token', token);
      _token = token;
    }
  }

  Future<String?> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    if (_token != null && JwtDecoder.isExpired(_token!)) {
      _token = null;
    }
    return _token;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    _token = null;
  }

  Future<void> login(String username, String password) async {
    try {
      final ApiUserResType res = await _dio.post(Config.login, data: {
        "username": username,
        "password": password,
        "deviceId": "1",
        "deviceOS": "Android",
        "deviceType": "s",
        "appVersion": "1.0"
      });
      if (res.statusCode == 200) {
        await saveToPrefs(res.data['jwtToken']['access_token']);
      } else {
        // print(res);
      }
      // print(res);
    } on DioException catch (e) {
      // Handle Dio error
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error: ${e.response!.data}');
        }
      } else {
        if (kDebugMode) {
          print('Error sending request: $e');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

// {
// "username": "string",
// "password": "string",
// "deviceId": "string",
// "deviceOS": "string",
// "deviceType": "string",
// "appVersion": "string"
// }
