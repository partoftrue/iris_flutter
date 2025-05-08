import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  Map<String, dynamic>? _userData;

  bool get isAuthenticated => _isAuthenticated;
  Map<String, dynamic>? get userData => _userData;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isAuthenticated = await AuthService.isAuthenticated();
    if (_isAuthenticated) {
      _userData = await AuthService.getUserData();
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final data = await AuthService.login(email, password);
      _isAuthenticated = true;
      _userData = data['user'];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(Map<String, dynamic> userData) async {
    try {
      final data = await AuthService.register(userData);
      _isAuthenticated = true;
      _userData = data['user'];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    _isAuthenticated = false;
    _userData = null;
    notifyListeners();
  }
} 