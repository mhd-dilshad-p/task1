import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required String name, required int age, String? imagePath})
      : super(name: name, age: age, imagePath: imagePath);
}