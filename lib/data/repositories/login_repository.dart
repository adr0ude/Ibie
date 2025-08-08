import 'package:flutter/material.dart';

import 'package:ibie/utils/results.dart';

import 'package:ibie/data/services/auth_service.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:ibie/data/services/shared_preferences_service.dart';

abstract class ILoginRepository extends ChangeNotifier {
  Future<Result<void>> loginEmail({required String email, required String password});
}

class LoginRepository extends ILoginRepository {
  LoginRepository({
    required AuthService authService,
    required DatabaseService databaseService,
    required SharedPreferencesService preferencesService,
  }) : _authService = authService,
       _databaseService = databaseService,
       _preferencesService = preferencesService;

  final AuthService _authService;
  final DatabaseService _databaseService;
  final SharedPreferencesService _preferencesService;

  @override
  Future<Result<void>> loginEmail({required String email, required String password}) async {
    try {
      final authResult = await _authService.loginEmail(email: email, password: password);
      switch (authResult) {
        case Ok(value: final firebaseUser):
          final fetchResult = await _databaseService.fetchUserData(userId: firebaseUser.uid);
          switch (fetchResult) {
            case Ok(value: final user):
              final saveUserResult = await _preferencesService.saveUserData(user: user);
              switch (saveUserResult) {
                case Ok():
                  final saveStateResult = await _preferencesService.saveStateCompleteProfileMessage(state: false);
                  switch (saveStateResult) {
                    case Ok():
                      return const Result.ok(null);
                    case Error(error: final e):
                      return Result.error(e);
                  }
                case Error(error: final e):
                  return Result.error(e);
              }
            case Error(error: final e):
              return Result.error(e);
          }
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }
}