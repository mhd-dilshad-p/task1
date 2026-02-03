import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  // Static list to keep data during app session
 static final List<UserEntity> _mockDb = [
  UserEntity(
    name: "Martin Dokidis", 
    age: 34, 
    imagePath: "https://i.pravatar.cc/150?img=1" // Network URL
  ),
  UserEntity(
    name: "Marilyn Rosser", 
    age: 34, 
    imagePath: "https://i.pravatar.cc/150?img=5" // Network URL
  ),
];

  @override
  Future<List<UserEntity>> fetchUsers() async => _mockDb;

  @override
  Future<void> addUser(UserEntity user) async => _mockDb.add(user);
}