import 'package:flutter/material.dart';
import 'package:ibie/data/repositories/activity_repository.dart';

import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/activity.dart';
import 'package:ibie/models/enrolled_activity.dart';
import 'package:ibie/utils/results.dart';

class ActivityDetailsViewmodel extends ChangeNotifier {
  ActivityDetailsViewmodel({
    required IActivityRepository activityRepository,
    required IUserRepository userRepository,
  }) : _activityRepository = activityRepository,
       _userRepository = userRepository;

  final IActivityRepository _activityRepository;
  final IUserRepository _userRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Activity? _activity;
  Activity? get activity => _activity;

  String get title => _activity?.title ?? '';
  String get userName => _activity?.userName ?? '';
  String get image => _activity?.image ?? '';
  String get description => _activity?.description ?? '';
  String get vacancies => _activity?.vacancies ?? '';
  List<String> get comments => _activity?.comments ?? [];

  List<EnrolledActivity> _activities = [];
  List<EnrolledActivity> get activities => _activities;

  String _comment = '';
  set comment(String value) {
    _comment = value.trim();
  }

  bool get isSubscribed {
    final activityId = _activity?.id;

    return _activities.any((a) => a.activity.id == activityId);
  }

  Future<Result<void>> init(String activityId) async {
    try {
      _isLoading = true;

      final activityResult = await _activityRepository.getActivityData(activityId: activityId); // pegar os dados da atividade
      switch (activityResult) {
        case Ok(value: final activity):
          _activity = activity;
          final activitiesResult = await _activityRepository.getEnrolledActivities(); // pegar a lista de atividades inscritas
          switch (activitiesResult) {
            case Ok(value: final activities):
              _activities = activities;
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

  Future<Result<void>> subscribe() async {
    try {
      _isLoading = true;
      final activityResult = await _activityRepository.subscribe(
        activity: _activity!,
      );
      switch (activityResult) {
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

  Future<Result<void>> unsubscribe() async {
    try {
      _isLoading = true;
      final activityResult = await _activityRepository.unsubscribe(
        activity: _activity!,
      );
      switch (activityResult) {
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

  Future<Result<void>> sendFeedback() async {
    try {
      _isLoading = true;
      final sendResult = await _activityRepository.sendFeedback(comment: _comment, activity: _activity!);
      switch (sendResult) {
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
}