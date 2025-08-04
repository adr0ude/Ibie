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

  bool _isLoading = false;
  User? _user;

  List<Activity> _activities = [];
  Map<String, List<Activity>> _categories = {};

  List<Activity> get activities => _activities;
  Map<String, List<Activity>> get categories => _categories;

  bool get isLoading => _isLoading;
  User? get user => _user;
  String get name => _user?.name ?? '';
  String get type => _user?.type ?? '';
  String get photo => _user?.photo ?? '';

  Future<Result<void>> init() async {
    try {
      _isLoading = true;
      final userResult = await _userRepository.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          _user = user;
          final activitiesResult = await _activityRepository.getActivities();
          switch (activitiesResult) {
            case Ok(value: final activities):
              _activities = activities;
              _categorizeActivities();
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

  void _categorizeActivities() {
    _categories = {};
    for (final activity in _activities) {
      _categories.putIfAbsent(activity.category, () => []).add(activity);
    }
  }
}