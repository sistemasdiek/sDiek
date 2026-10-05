import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../core/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        _errorMessage = 'Por favor ingrese correo y contraseña';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _currentUser = await _authService.login(email.trim(), password.trim());
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Credenciales inválidas o error de conexión';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }
}
