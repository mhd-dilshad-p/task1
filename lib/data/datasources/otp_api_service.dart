import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class OtpApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://control.msg91.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'authkey': '492255AQlUGmGfwYdi6982fdcdP1', 
      },
    ),
  );

  static const String _templateId = '6983018da18fda79c92c4df0'; 


  static Future<bool> sendOtp(String phoneNumber) async {
    try {
      final mobile = phoneNumber.replaceAll(RegExp(r'\D'), '');

      final response = await _dio.post(
        '/api/v5/otp',
        data: {
          "template_id": _templateId,
          "mobile": mobile,
        },
      );

      debugPrint("Send OTP Response: ${response.data}");

      return response.data['type'] == 'success';
    } on DioException catch (e) {
      debugPrint("Dio Error: ${e.response?.data ?? e.message}");
      return false;
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      return false;
    }
  }
}
