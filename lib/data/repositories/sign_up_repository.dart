import 'package:flutter/material.dart';

import 'package:ibie/utils/results.dart';
import 'package:ibie/models/user.dart';

import 'package:ibie/data/services/auth_service.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:ibie/data/services/shared_preferences_service.dart';

abstract class ISignUpRepository extends ChangeNotifier {
  Future<Result<void>> signUpEmail({required User user});
  Future<Result<void>> registerCategories({required List<String> categories});
}

class SignUpRepository extends ISignUpRepository {
  SignUpRepository({
    required AuthService authService,
    required DatabaseService databaseService,
    required SharedPreferencesService preferencesService,
  })  : _authService = authService,
        _databaseService = databaseService,
        _preferencesService = preferencesService;

  final AuthService _authService;
  final DatabaseService _databaseService;
  final SharedPreferencesService _preferencesService;

  @override
  Future<Result<void>> signUpEmail({required User user}) async {
    try {
      final authResult = await _authService.signUpEmail(email: user.email, password: user.password);

      switch (authResult) {
        case Ok(value: final firebaseUser):
          user = user.copyWith(id: firebaseUser.uid);

          final databaseResult = await _databaseService.setUserData(user);
          switch (databaseResult) {
            case Ok():

              final preferencesResult = await _preferencesService.saveUserData(user: user);
                switch (preferencesResult) {
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
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> registerCategories({required List<String> categories}) async {
    try {
      final userResult = await _preferencesService.getUserData();
      switch (userResult) {
        case Ok(value: final user):

          final databaseResult = await _databaseService.registerCategories(user.id, categories);
          switch (databaseResult) {
            case Ok():
              return const Result.ok(null);
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