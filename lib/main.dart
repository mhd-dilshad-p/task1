import 'package:flutter/material.dart';
import 'package:machine_text/domain/usecases/add_user_usecase.dart';
import 'package:machine_text/domain/usecases/get_users_usecase.dart';
import 'package:provider/provider.dart';
import 'data/repositories/user_repository_impl.dart';

import 'presentation/providers/user_provider.dart';
import 'presentation/screens/login_screen.dart'; // <-- Import LoginScreen


void main() {
  // Initialize repository and use cases
  final repo = UserRepositoryImpl();
  final getUsersUC = GetUsersUseCase(repo);
  final addUserUC = AddUserUseCase(repo);

  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(
        getUsersUC: getUsersUC,
        addUserUC: addUserUC,
      )..loadUsers(), // Load users in the background
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // CHANGE THIS LINE to LoginScreen()
        home: LoginScreen(), 
      ),
    ),
  );
}