import 'package:get_it/get_it.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/get_users_usecase.dart';
import 'domain/usecases/add_user_usecase.dart';
import 'presentation/providers/user_provider.dart';

final sl = GetIt.instance; // sl = Service Locator

void init() {
  // Provider
  sl.registerFactory(() => UserProvider(getUsersUC: sl(), addUserUC: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton(() => AddUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}