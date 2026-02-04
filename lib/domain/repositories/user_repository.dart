import '../entities/user_entity.dart';

abstract class UserRepository {

  Future<List<UserEntity>> fetchUsers();
  Future<void> addUser(UserEntity user);


  Future<bool> sendOtp(String phoneNumber);
  Future<bool> verifyOtp(String phoneNumber, String otp);

  
  Future<bool> uploadUserData({
    required String name,
    required String phoneNumber,
    required String imagePath,
  });
}