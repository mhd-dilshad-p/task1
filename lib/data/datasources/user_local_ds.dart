import '../models/user_model.dart';


abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> users);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<List<UserModel>> getCachedUsers() {

    throw UnimplementedError();
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) {

    throw UnimplementedError();
  }
}
