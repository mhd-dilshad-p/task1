import 'package:get_it/get_it.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/get_users_usecase.dart';
import 'domain/usecases/add_user_usecase.dart';
import 'domain/usecases/auth_usecases.dart'; 
import 'presentation/providers/user_provider.dart';

final sl = GetIt.instance;

void init() {
  
  sl.registerFactory(() => UserProvider(
    getUsersUC: sl(),
    addUserUC: sl(),
    sendOtpUC: sl(),
    verifyOtpUC: sl(),
  ));

  
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton(() => AddUserUseCase(sl()));
  sl.registerLazySingleton(() => SendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));

  
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}