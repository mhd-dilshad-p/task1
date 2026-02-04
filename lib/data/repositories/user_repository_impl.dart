import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://control.msg91.com',
      headers: {
        'Content-Type': 'application/json',
        'authkey': 'YOUR_MSG91_AUTH_KEY', 
      },
    ),
  );

  final String _templateId = 'YOUR_TEMPLATE_ID'; 

  static final List<UserEntity> _mockDb = [
    UserEntity(name: "Martin Dokidis", age: 34, imagePath: ""),
    UserEntity(name: "Marilyn Elder", age: 65, imagePath: ""),
  ];



  @override
  Future<bool> sendOtp(String phoneNumber) async {
    try {
      final cleanPhone = phoneNumber.replaceAll(RegExp(r'\D'), '');

      final response = await _dio.post(
        '/api/v5/otp',
        data: {
          "template_id": _templateId,
          "mobile": cleanPhone,
        },
      );

      debugPrint("Send OTP Response: ${response.data}");
      return response.data['type'] == 'success';
    } catch (e) {
      debugPrint("Send OTP Error: $e");
      return false;
    }
  }

  @override
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
   
    return otp == '123456';
  }

 

  @override
  Future<List<UserEntity>> fetchUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDb;
  }

  @override
  Future<void> addUser(UserEntity user) async {
    _mockDb.add(user);
  }

  @override
  Future<bool> uploadUserData({
    required String name,
    required String phoneNumber,
    required String imagePath,
  }) async {
    return true; 
  }
}
