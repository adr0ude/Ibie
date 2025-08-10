import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/activity_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/activity.dart';

import 'package:ibie/models/enrolled_activity.dart';
import 'package:ibie/models/user.dart';
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

  User? _user;
  User? get user => _user;
  String get type => _user == null ? '' : _user!.type;

  List<EnrolledActivity> _enrolledActivities = [];
  List<EnrolledActivity> get enrolledActivities => _enrolledActivities;

  List<Activity> _myActivities = [];
  List<Activity> get myActivities => _myActivities;

  Future<Result<void>> init() async {
    try {
      _isLoading = true;

      final userResult = await _userRepository.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          _user = user;
          final enrolledResult = await _activityRepository.getEnrolledActivities();
          switch (enrolledResult) {
            case Ok(value: final enrolledActivities):
              _enrolledActivities = enrolledActivities;
              final myResult = await _activityRepository.getInstructorActivities(instructorId: user.id);
              switch (myResult) {
                case Ok(value: final myActivities):
                  _myActivities = myActivities;
                  return Result.ok(null);
                case Error(error: final e):
                  if (e.toString().contains("O usuário não é um instrutor")) {
                    return Result.ok(null);
                  } else {
                    return Result.error(e);
                  }
              }
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
}