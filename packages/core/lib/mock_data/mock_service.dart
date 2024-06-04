import 'dart:convert';

import 'package:core/mock_data/mock_data.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class MockService {
  static final MockService _instance = MockService._();
  MockData _data = MockData();

  MockService._();

  Future<void> loadMockData(String jsonPath, {String package = 'core'}) async {
    String fullJsonPath = path.join("packages", package, jsonPath);
    String jsonStr = await rootBundle.loadString(fullJsonPath);
    Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    _data = MockData.fromJson(jsonMap);
  }

  static get instance {
    return _instance;
  }

  MockData get mock => _data;
}
