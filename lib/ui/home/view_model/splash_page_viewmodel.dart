import 'package:flutter/foundation.dart';

import 'package:ibie/utils/results.dart';
import 'package:ibie/data/repositories/login_repository.dart';

class SplashPageViewModel extends ChangeNotifier {
  SplashPageViewModel({
    required ILoginRepository loginRepository,
  })  : _loginRepository = loginRepository;

  final ILoginRepository _loginRepository;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<Result> checkLoginStatus() async {
    final result = await _loginRepository.isUserLoggedIn();
    switch(result) {
      case Ok(value: final confirm):
        _isLoggedIn = confirm;
        notifyListeners();
        return const Result.ok(null);
      case Error(error: final e):
        return Result.error(e);
    }
  }
}