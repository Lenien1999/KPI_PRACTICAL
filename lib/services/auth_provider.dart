import 'package:flutter/material.dart';
import 'api_service.dart';


class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isAuthenticated = false;
  final ApiService _apiService = ApiService();

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      _token = response['token'];
      _isAuthenticated = true;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      await _apiService.signup(name, email, password);
    } catch (error) {
      rethrow;
    }
  }

  void logout() {
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
