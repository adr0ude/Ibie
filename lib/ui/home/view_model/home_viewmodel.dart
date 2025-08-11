import 'package:flutter/material.dart';
import 'package:ibie/data/repositories/activity_repository.dart';

import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/activity.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel({
    required IUserRepository userRepository,
    required IActivityRepository activityRepository,
  }) : _userRepository = userRepository,
       _activityRepository = activityRepository;

  final IUserRepository _userRepository;
  final IActivityRepository _activityRepository;

  bool _isLoggedIn = false;
  bool _isLoading = false;
  bool _hasShowCompleteProfileMessage = false;
  User? _user;
  bool _showFavorites = false;
  bool get showFavorites => _showFavorites;
  set showFavorites(bool value) {
    if (_showFavorites != value) {
      _showFavorites = value;
      notifyListeners();
    }
  }

  List<Activity> _favorites = [];
  List<Activity> get favorites => _favorites;
  Map<String, List<Activity>> _favoritesCategories = {};
  Map<String, List<Activity>> get favoritesCategories => _favoritesCategories;

  void _categorizeFavorites() {
    _favoritesCategories = {};
    for (final activity in _favorites) {
      _favoritesCategories.putIfAbsent(activity.category, () => []).add(activity);
    }
  }

  List<Activity> _activities = [];
  Map<String, List<Activity>> _categories = {};

  List<Activity> get activities => _activities;
  Map<String, List<Activity>> get categories => _categories;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  bool get hasShowCompleteProfileMessage => _hasShowCompleteProfileMessage;
  User? get user => _user;
  String get name => _user?.name ?? '';
  String get type => _user?.type ?? '';
  String get photo => _user?.photo ?? '';
  String get biography => _user?.biography ?? '';

  Future<Result<void>> init() async {
    try {
      _isLoading = true;
      final activitiesResult = await _activityRepository.getActivities();
      switch (activitiesResult) {
        case Ok(value: final activities):
          _activities = activities;
          _categorizeActivities();
          final uidResult = await _userRepository.isLoggedIn();
          switch (uidResult) {
            case Ok():
              final userResult = await _userRepository.getUserData();
              switch (userResult) {
                case Ok(value: final user):
                  _user = user;
                  _isLoggedIn = true;
                  return Result.ok(null);
                case Error(error: final e):
                  return Result.error(e);
              }
            case Error(error: final e):
              if (e.toString().contains("Nenhum usuário está autenticado")) {
                _isLoggedIn = false;
                return Result.ok(null);
              } else {
                return Result.error(e);
              }
          }
        case Error(error: final e):
          return Result.error(e);
        }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _categorizeActivities() {
    _categories = {};
    for (final activity in _activities) {
      _categories.putIfAbsent(activity.category, () => []).add(activity);
    }
  }

  Future<Result<void>> listFavorites() async {
    try {
      _isLoading = true;
      final userResult = await _userRepository.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          _user = user;
          final favoritesResult = await _activityRepository.getFavoritesActivities(userId: user.id);
          switch (favoritesResult) {
            case Ok(value: final favorites):
              _favorites = favorites;
              _categorizeFavorites();  // categoriza as favoritas
              return Result.ok(null);
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

  Future<Result<void>> logOut() async {
    try {
      _isLoading = true;
      final logOutResult = await _userRepository.logOut();
      switch (logOutResult) {
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

  Future<Result<void>> setCompleteProfileMessage() async {
    try {
      final setOutResult = await _userRepository.setStateCompleteProfileMessage(state: true);
      switch (setOutResult) {
        case Ok():
          _hasShowCompleteProfileMessage = true;
          return Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> getCompleteProfileMessage() async {
    try {
      final stateResult = await _userRepository.getStateCompleteProfileMessage();
      switch (stateResult) {
        case Ok(value: final state):
          _hasShowCompleteProfileMessage = state;
          return Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }
}