import 'package:flutter/material.dart';
import 'package:ibie/data/repositories/activity_repository.dart';

import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/enrolled_activity.dart';
import 'package:ibie/utils/results.dart';

class MyActivitiesViewmodel extends ChangeNotifier {
  MyActivitiesViewmodel({
    required IActivityRepository activityRepository,
    required IUserRepository userRepository,
  }) : _activityRepository = activityRepository,
       _userRepository = userRepository;

  final IActivityRepository _activityRepository;
  final IUserRepository _userRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<EnrolledActivity> _activities = [];
  List<EnrolledActivity> get activities => _activities;

  Future<Result<void>> init() async {
    try {
      _isLoading = true;

      final activitiesResult = await _activityRepository.getEnrolledActivities();
      switch (activitiesResult) {
        case Ok(value: final activities):
          _activities = activities;
          return Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}