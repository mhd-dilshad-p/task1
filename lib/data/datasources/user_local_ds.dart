import '../models/user_model.dart';

/// Local data source for users (local DB / cache)
abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> users);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<List<UserModel>> getCachedUsers() {
    // TODO: implement local retrieval
    throw UnimplementedError();
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) {
    // TODO: implement cache write
    throw UnimplementedError();
  }
}
