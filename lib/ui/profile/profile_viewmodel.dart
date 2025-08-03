import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

class ProfileViewmodel extends ChangeNotifier {
  ProfileViewmodel({required IUserRepository userRepository})
    : _userRepository = userRepository;

  final IUserRepository _userRepository;

  bool _isLoading = false;
  User? _user;
  String _newPhoto = '';
  bool _changePhoto = false;

  bool get isLoading => _isLoading;
  String get name => _user?.name ?? '';
  String get photo => _user?.photo ?? '';
  String get cpf => _user?.cpf ?? '';
  String get dateBirth => _user?.dateBirth ?? '';
  String get city => _user?.city ?? '';
  String get phone => _user?.phone ?? '';
  String get email => _user?.email ?? '';
  String get biography => _user?.biography ?? '';
  String get type => _user?.type ?? '';

  String get newPhoto => _newPhoto;

  bool get isFormValid =>
      (_user?.name.trim().isNotEmpty ?? false) &&
      (_user?.phone.trim().isNotEmpty ?? false) &&
      (_user?.city.trim().isNotEmpty ?? false) &&
      (_user?.dateBirth.trim().isNotEmpty ?? false);

  set name(String value) {
    if (_user != null) {
      _user = _user!.copyWith(name: value.trim());
      notifyListeners();
    }
  }

  set newPhoto(String value) {
    _newPhoto = value;
  }

  set dateBirth(String value) {
    if (_user != null) {
      _user = _user!.copyWith(dateBirth: value.trim());
      notifyListeners();
    }
  }

  set city(String value) {
    if (_user != null) {
      _user = _user!.copyWith(city: value.trim());
      notifyListeners();
    }
  }

  set phone(String value) {
    if (_user != null) {
      _user = _user!.copyWith(phone: value.trim());
      notifyListeners();
    }
  }

  set biography(String value) {
    if (_user != null) {
      _user = _user!.copyWith(biography: value.trim());
      notifyListeners();
    }
  }

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

  Future<Result<void>> updateUserData() async {
    if (!isFormValid) {
      return Result.error(Exception("Preencha todos os campos corretamente"));
    }
    _isLoading = true;
    notifyListeners();

    try {
      Result<void> result;

      if (_changePhoto) {
        result = await _userRepository.updateUserData(
          user: _user!,
          newPhoto: _newPhoto,
        );
      } else {
        result = await _userRepository.updateUserData(user: _user!);
      }

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

  Future<Result<void>> sendEmail() async {
    try {
      _isLoading = true;
      final result = await _userRepository.sendPasswordResetEmail();
      switch (result) {
        case Ok():
          return Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Result<void>> pickImage(String source) async {
    try {
      _isLoading = true;
      notifyListeners();
      final photoResult = await _userRepository.pickProfileImage(
        source: source,
      );

      switch (photoResult) {
        case Ok(value: final picture):
          _newPhoto = picture!;
          _changePhoto = true;
          return const Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Result<void>> deletePhoto() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_user!.photo.isEmpty && _newPhoto.isEmpty) {
        return const Result.ok(null);
      }

      if (_user!.photo.isEmpty && _newPhoto.isNotEmpty) {
        _newPhoto = '';
        return const Result.ok(null);
      }

      if (_user!.photo.isNotEmpty) {
        _newPhoto = '';
        final deleteResult = await _userRepository.deleteProfileImage(
          user: _user!,
        );

        switch (deleteResult) {
          case Ok():
            return const Result.ok(null);
          case Error(error: final e):
            return Result.error(e);
        }
      }
      return const Result.ok(null);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}