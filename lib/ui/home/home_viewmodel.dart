import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel({
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  final IUserRepository _userRepository;

  bool _isLoading = false;
  User? _user;

  bool get isLoading => _isLoading;
  User? get user => _user;
  String get name => _user?.name ?? '';
  String get type => _user?.type ?? '';
  String get photo => _user?.photo ?? '';

  // Carregar dados do usuário, os cursos...
  Future<Result<void>> init() async {
    try {
      _isLoading = true;
      final userResult = await _userRepository.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          _user = user;
          return Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}