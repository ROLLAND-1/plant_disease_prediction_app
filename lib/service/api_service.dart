import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_onboarding/enums/plant_type.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants.dart';
import '../models/api_response.dart';

class ApiService {
  static ApiService instance = ApiService._();
  late Dio _dio;
  ApiService._() {
    _dio = Dio();
  }

  String getUrl(PlantType plantType) {
    switch (plantType) {
      case PlantType.CORN:
        return '${BASE_URL}corn';
      case PlantType.POTATO:
        return '${BASE_URL}potato';
      case PlantType.PEPPER:
        return '${BASE_URL}pepper';

      default:
        throw Exception("Unemplemented");
    }
  }

  Future<ApiResponse?> getPrediction(File file, PlantType plantType) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      var res = await _dio.post(getUrl(plantType), data: formData);
      return ApiResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (e) {}
    return null;
  }
}
