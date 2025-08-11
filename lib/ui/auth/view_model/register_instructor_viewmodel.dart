import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/sign_up_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

class RegisterInstructorViewmodel extends ChangeNotifier {
  RegisterInstructorViewmodel({
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
  String? _city;
  String _phone = '';
  String _email = '';
  String _password = '';

  bool get isLoading => _isLoading;
  String? get city => _city;
  String get photo => _photo;

  bool get isFormValid => _email.isNotEmpty && _password.isNotEmpty;

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
      type: 'instructor',
      name: _name,
      photo: _photo,
      cpf: _cpf,
      dateBirth: _dateBirth,
      city: _city ?? '',
      phone: _phone,
      email: _email,
      password: _password,
      biography: '',
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
      final result = await _signUpRepository.signUpEmail(user: user);

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

  Future<Result<void>> pickImage(String source) async {
    try {
      _isLoading = true;
      notifyListeners();
      final photoResult = await _userRepository.pickProfileImage(
        source: source,
      );

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

  String? validateCpf(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o CPF.';
    }

    final cpf = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cpf.length != 11 || RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
      return 'Informe um CPF válido.';
    }

    int calcCheckDigit(String str, int length) {
      int sum = 0;
      for (int i = 0; i < length; i++) {
        sum += int.parse(str[i]) * ((length + 1) - i);
      }
      int mod = sum % 11;
      return (mod < 2) ? 0 : 11 - mod;
    }

    final d1 = calcCheckDigit(cpf, 9);
    final d2 = calcCheckDigit(cpf.substring(0, 9) + d1.toString(), 10);

    if (cpf != cpf.substring(0, 9) + d1.toString() + d2.toString()) {
      return 'Informe um CPF válido.';
    }

    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe a data de nascimento.';
    }

    final parts = value.split('/');

    if (parts.length != 3) {
      return 'Informe uma data válida no formato dd/mm/aaaa.';
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Data inválida.';
    }

    try {
      final date = DateTime(year, month, day);
      final now = DateTime.now();

      if (date.day != day || date.month != month || date.year != year) {
        return 'Data inválida.';
      }

      if (date.isAfter(now)) {
        return 'Informe uma data de nascimento válida.';
      }

      final age =
          now.year -
          date.year -
          ((now.month < date.month ||
                  (now.month == date.month && now.day < date.day))
              ? 1
              : 0);

      if (age < 0 || age > 130) {
        return 'Informe uma data de nascimento válida.';
      }
    } catch (_) {
      return 'Data inválida.';
    }

    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o telefone.';
    }

    final phone = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (phone.length < 10 || phone.length > 11) {
      return 'Informe um número de telefone válido.';
    }

    if (phone.length == 11 && phone[2] != '9') {
      return 'Informe um número de telefone válido.';
    }

    return null;
  }
}