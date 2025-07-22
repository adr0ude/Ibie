import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/login_repository.dart';
import 'package:ibie/utils/results.dart';

class LoginViewmodel extends ChangeNotifier {
  LoginViewmodel({
    required ILoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  final ILoginRepository _loginRepository;

  bool _isLoading = false;
  String _email = '';
  String _password = '';

  bool get isLoading => _isLoading;

  bool get isFormValid =>
      _email.isNotEmpty &&
      _password.isNotEmpty;

  set email(String value) {
    _email = value.trim();
  }

  set password(String value) {
    _password = value.trim();
  }

  Future<Result<void>> loginEmail() async {
    if (!isFormValid) {
      return Result.error(Exception("Preencha todos os campos corretamente"));
    }
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _loginRepository.loginEmail(email: _email, password: _password);

      switch (result) {
        case Ok():
          return const Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}