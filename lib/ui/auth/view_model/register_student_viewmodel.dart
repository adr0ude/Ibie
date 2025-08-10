import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/sign_up_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

class RegisterStudentViewmodel extends ChangeNotifier {
  RegisterStudentViewmodel({
    required ISignUpRepository signUpRepository,
    required IUserRepository userRepository,
  }) : _signUpRepository = signUpRepository,
       _userRepository = userRepository;

  final ISignUpRepository _signUpRepository;
  final IUserRepository _userRepository;

  bool _isLoading = false;
  String _name = '';
  String _photo = '';
  String _cpf = '';
  String _dateBirth = '';
  String? _city = '';
  String _phone = '';
  String _email = '';
  String _password = '';
  List<String> _selectedCategories = [];

  bool get isLoading => _isLoading;
  String? get city => _city;
  String get photo => _photo;
  List<String> get selectedCategories => _selectedCategories;

  void changeList(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  bool get isFormValid =>
      _email.isNotEmpty &&
      _password.isNotEmpty;

  set name(String value) {
    _name = value.trim();
  }

  set photo(String value) {
    _photo = value.trim();
  }

  set cpf(String value) {
    _cpf = value.trim();
  }

  set dateBirth(String value) {
    _dateBirth = value.trim();
  }

  set city(String? value) {
    _city = value?.trim();
  }

  set phone(String value) {
    _phone = value.trim();
  }

  set email(String value) {
    _email = value.trim();
  }

  set password(String value) {
    _password = value.trim();
  }

  User toUser() {
    return User(
      id: '',
      type: 'student',
      name: _name,
      photo: _photo,
      cpf: _cpf,
      dateBirth: _dateBirth,
      city: _city ?? '',
      phone: _phone,
      email: _email,
      password: _password,
      biography: ''
    );
  }

  Future<Result<void>> signUpEmail() async {
    if (!isFormValid) {
      return Result.error(Exception("Preencha todos os campos corretamente"));
    }
    _isLoading = true;
    notifyListeners();

    try {
      final user = toUser();
      final authResult = await _signUpRepository.signUpEmail(user: user);

      switch (authResult) {
        case Ok():
          final registerResult = await registerCategories();
          switch (registerResult) {
            case Ok():
              return const Result.ok(null);
            case Error(error: final e):
              return Result.error(e);
          }
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Result<void>> registerCategories() async {
    if (_selectedCategories.isEmpty) {
      return const Result.ok(null);
    }
    try {

      final result = await _signUpRepository.registerCategories(categories: _selectedCategories);

      switch (result) {
        case Ok():
          return const Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }
  
  Future<Result<void>> pickImage(String source) async {
    try {
      _isLoading = true;
      notifyListeners();
      final photoResult = await _userRepository.pickProfileImage(source: source);

      switch (photoResult) {
        case Ok(value: final picture):
          _photo = picture!;
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