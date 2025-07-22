import 'package:flutter/material.dart';

import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

import 'package:ibie/data/services/shared_preferences_service.dart';

abstract class IUserRepository extends ChangeNotifier {
  Future<Result<User>> getUserData();
}

class UserRepository extends IUserRepository {
  UserRepository({
    required SharedPreferencesService preferencesService}) 
    : _preferencesService = preferencesService;

  final SharedPreferencesService _preferencesService;

  @override
  Future<Result<User>> getUserData() async {
    try {
      final userResult = await _preferencesService.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          return Result.ok(user);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }
}