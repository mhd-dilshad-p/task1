import '../models/user_model.dart';

/// Remote data source for users (API calls)
abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<List<UserModel>> fetchUsers() {
    // TODO: implement API call
    throw UnimplementedError();
  }
}
