import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/add_user_usecase.dart';
import '../../domain/usecases/auth_usecases.dart';

class UserProvider extends ChangeNotifier {
  final GetUsersUseCase getUsersUC;
  final AddUserUseCase addUserUC;
  final SendOtpUseCase sendOtpUC;
  final VerifyOtpUseCase verifyOtpUC;

  UserProvider({
    required this.getUsersUC,
    required this.addUserUC,
    required this.sendOtpUC,
    required this.verifyOtpUC,
  });


  List<UserEntity> _allUsers = [];
  String _searchQuery = "";
  String _selectedFilter = "All"; 
  String _phoneNumber = ""; 
  bool _isLoading = false;

  
  bool get isLoading => _isLoading;
  String get phoneNumber => _phoneNumber;
  String get selectedFilter => _selectedFilter;


  List<UserEntity> get filteredUsers {
    List<UserEntity> results = _allUsers;

 
    if (_selectedFilter == "Age: Elder") {
      results = results.where((u) => u.age >= 60).toList();
    } else if (_selectedFilter == "Age: Younger") {
      results = results.where((u) => u.age < 60).toList();
    }


    if (_searchQuery.isNotEmpty) {
      results = results.where((u) => 
        u.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return results;
  }



  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();
    _allUsers = await getUsersUC();
    _isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }


  Future<bool> createAndUploadUser({
    required String name,
    required int age,
    required String? imagePath,
  }) async {
    _isLoading = true;
    notifyListeners();

    bool apiSuccess = await getUsersUC.repository.uploadUserData(
      name: name,
      phoneNumber: _phoneNumber,
      imagePath: imagePath ?? "",
    );

    await addUserUC(UserEntity(name: name, age: age, imagePath: imagePath));
    await loadUsers();

    _isLoading = false;
    notifyListeners();
    return apiSuccess;
  }



  Future<bool> requestOtp(String phone) async {
    _phoneNumber = phone; 
    notifyListeners();
    
    return true; 
  }

  Future<bool> validateOtp(String otp) async {
    return true; 
  }
}