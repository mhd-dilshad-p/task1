import 'package:flutter/material.dart';
import 'package:machine_text/domain/usecases/add_user_usecase.dart';
import 'package:machine_text/domain/usecases/get_users_usecase.dart';
import '../../domain/entities/user_entity.dart';


class UserProvider extends ChangeNotifier {
  final GetUsersUseCase getUsersUC;
  final AddUserUseCase addUserUC;

  UserProvider({required this.getUsersUC, required this.addUserUC});

  List<UserEntity> _allUsers = [];
  String _selectedFilter = "All"; 
  String _searchQuery = ""; // New: Search query state

  String get selectedFilter => _selectedFilter;

  // Optimized Logic: Filters by Age AND Name together
  List<UserEntity> get filteredUsers {
    List<UserEntity> results = _allUsers;

    // 1. Apply Age Filter
    if (_selectedFilter == "Age: Elder") {
      results = results.where((user) => user.age >= 60).toList();
    } else if (_selectedFilter == "Age: Younger") {
      results = results.where((user) => user.age < 60).toList();
    }

    // 2. Apply Search Filter (Case-insensitive)
    if (_searchQuery.isNotEmpty) {
      results = results.where((user) => 
        user.name.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return results;
  }

  Future<void> loadUsers() async {
    _allUsers = await getUsersUC();
    notifyListeners();
  }

  // Called when typing in the search bar
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  Future<void> addUser(String name, int age, String? imagePath) async {
    final newUser = UserEntity(name: name, age: age, imagePath: imagePath);
    await addUserUC(newUser);
    await loadUsers();
  }
}