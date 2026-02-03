import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> fetchUsers();
  Future<void> addUser(UserEntity user);
}