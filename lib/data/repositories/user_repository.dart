import 'package:flutter/material.dart';

import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

import 'package:ibie/data/services/shared_preferences_service.dart';
import 'package:ibie/data/services/auth_service.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:ibie/data/services/image_service.dart';
import 'package:ibie/data/services/storage_service.dart';

abstract class IUserRepository extends ChangeNotifier {
  Future<Result<User>> getUserData();
  Future<Result<void>> updateUserData({required User user, String? newPhoto});
  Future<Result<void>> sendPasswordResetEmail({String? email});
  Future<Result<String?>> pickProfileImage({required String source});
  Future<Result<void>> deleteProfileImage({required User user});
}

class UserRepository extends IUserRepository {
  UserRepository({
    required SharedPreferencesService preferencesService,
    required DatabaseService databaseService,
    required AuthService authService,
    required ImageService imageService,
    required StorageService storageService,
  }) : _preferencesService = preferencesService,
       _databaseService = databaseService,
       _authService = authService,
       _imageService = imageService,
       _storageService = storageService;

  final SharedPreferencesService _preferencesService;
  final DatabaseService _databaseService;
  final AuthService _authService;
  final ImageService _imageService;
  final StorageService _storageService;

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

  @override
  Future<Result<void>> updateUserData({
    required User user,
    String? newPhoto,
  }) async {
    try {
      if (newPhoto != null) {
        // se há uma nova foto
        if (user.photo.isNotEmpty) {
          // se já havia uma foto
          final deleteResult = await _storageService.deleteImage(
            user.photo,
          ); // deleta a antiga
          switch (deleteResult) {
            case Ok():
              break;
            case Error(error: final e):
              return Result.error(e);
          }
        }
        final imageResult = await _storageService.uploadUserImage(
          newPhoto,
        ); // upload da nova
        switch (imageResult) {
          case Ok(value: final imageUrl):
            user = user.copyWith(photo: imageUrl);
            break;
          case Error(error: final e):
            return Result.error(e);
        }
      }

      if (newPhoto != null) {
        // se há uma nova foto
        if (newPhoto.isEmpty && user.photo.isNotEmpty) {
          // ela é vazia e a antiga não
          final deleteResult = await _storageService.deleteImage(
            user.photo,
          ); // deleta a antiga
          switch (deleteResult) {
            case Ok():
              break;
            case Error(error: final e):
              return Result.error(e);
          }
          user = user.copyWith(photo: '');
        }
      }

      final databaseResult = await _databaseService.updateUserData(user);
      switch (databaseResult) {
        case Ok():
          final preferencesResult = await _preferencesService.saveUserData(
            user: user,
          );
          switch (preferencesResult) {
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

  @override
  Future<Result<void>> deleteProfileImage({required User user}) async {
    try {
      final deleteResult = await _storageService.deleteImage(
        user.photo,
      ); // deleta a antiga
      switch (deleteResult) {
        case Ok():
          user = user.copyWith(photo: '');
          final databaseResult = await _databaseService.updateUserData(
            user,
          ); // atualiza
          switch (databaseResult) {
            case Ok():
              final preferencesResult = await _preferencesService.saveUserData(
                user: user,
              );
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
  Future<Result<void>> sendPasswordResetEmail({String? email}) async {
    try {
      if (email != null) {
        final sendResult = await _authService.sendPasswordResetEmail(email);

        switch (sendResult) {
          case Ok():
            return const Result.ok(null);
          case Error(error: final e):
            return Result.error(e);
        }
      } else {
        final userResult = await _preferencesService.getUserData();

        switch (userResult) {
          case Ok(value: final user):
            final sendResult = await _authService.sendPasswordResetEmail(user.email);

            switch (sendResult) {
              case Ok():
                return const Result.ok(null);
              case Error(error: final e):
                return Result.error(e);
            }
          case Error(error: final e):
            return Result.error(e);
        }
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<String?>> pickProfileImage({required String source}) async {
    try {
      Result<String?> imageResult;

      if (source == 'camera') {
        imageResult = await _imageService.pickImageFromCamera();
      } else if (source == 'gallery') {
        imageResult = await _imageService.pickImageFromGallery();
      } else {
        return Result.error(Exception('Fonte inválida'));
      }

      switch (imageResult) {
        case Ok(value: final newImage):
          if (newImage != null) {
            return Result.ok(newImage);
          } else {
            return Result.ok(null);
          }
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }
}
