import 'package:flutter/material.dart';
import 'package:ibie/data/services/shared_preferences_service.dart';

import 'package:ibie/models/activity.dart';
import 'package:ibie/models/enrolled_activity.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/data/services/database_service.dart';

abstract class IActivityRepository extends ChangeNotifier {
  Future<Result<void>> createActivity({required Activity activity});
  Future<Result<List<Activity>>> getActivities();
  Future<Result<void>> updateActivity({required Activity activity});
  Future<Result<void>> deleteActivity({required String activityId});
  Future<Result<List<EnrolledActivity>>> getEnrolledActivities();
  Future<Result<List<Activity>>> getInstructorActivities({required String instructorId});
  Future<Result<Activity>> getActivityData({required String activityId});
  Future<Result<void>> subscribe({required Activity activity});
  Future<Result<void>> unsubscribe({required Activity activity});
  Future<Result<void>> sendFeedback({required Activity activity, required String comment});
  Future<Result<User>> getInstructorData({required String instructorId});
}

class ActivityRepository extends IActivityRepository {
  final DatabaseService _databaseService;
  final SharedPreferencesService _preferencesService;

  ActivityRepository({
    required DatabaseService databaseService,
    required SharedPreferencesService preferencesService,
  }) : _databaseService = databaseService,
       _preferencesService = preferencesService;

  @override
  Future<Result<void>> createActivity({required Activity activity}) async {
    try {
      final userResult = await _preferencesService.getUserData();

      switch (userResult) {
        case Ok(value: final user):
          final updatedActivity = activity.copyWith(
            userId: user.id,
            userName: user.name,
          );

          final result = await _databaseService.createActivity(activity: updatedActivity);
          return result;

        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<Activity>>> getActivities() async {
    try {
      final activitiesResult = await _databaseService.getActivitiesHome();
      switch (activitiesResult) {
        case Ok(value: final activities):
          return Result.ok(activities);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> updateActivity({required Activity activity}) async {
    final result = await _databaseService.updateActivity(activity: activity);
    notifyListeners();
    return result;
  }

  @override
  Future<Result<void>> deleteActivity({required String activityId}) async {
    final result = await _databaseService.deleteActivity(activityId: activityId);
    notifyListeners();
    return result;
  }

  @override
  Future<Result<List<EnrolledActivity>>> getEnrolledActivities() async {
    try {
      final userResult = await _preferencesService.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          final listResult = await _databaseService.getEnrolledActivities(userId: user.id);
          switch (listResult) {
            case Ok(value: final list):
              return Result.ok(list);
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
  Future<Result<List<Activity>>> getInstructorActivities({required String instructorId}) async {
    try {
      final listResult = await _databaseService.getInstructorActivities(instructorId: instructorId);
      switch (listResult) {
        case Ok(value: final list):
          return Result.ok(list);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<Activity>> getActivityData({required String activityId}) async {
    try {
      final activityResult = await _databaseService.getActivityData(activityId: activityId);
      switch (activityResult) {
        case Ok(value: final activity):
          return Result.ok(activity);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<User>> getInstructorData({required String instructorId}) async {
    try {
      final instructorResult = await _databaseService.getInstructorData(instructorId: instructorId);
      switch (instructorResult) {
        case Ok(value: final instructor):
          return Result.ok(instructor);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> subscribe({required Activity activity}) async {
    try {
      final userResult = await _preferencesService.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          final subscribeResult = await _databaseService.subscribe(user: user, activity: activity);
          switch (subscribeResult) {
            case Ok():
              return Result.ok(null);
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
  Future<Result<void>> unsubscribe({required Activity activity}) async {
    try {
      final userResult = await _preferencesService.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          final subscribeResult = await _databaseService.unsubscribe(user: user, activity: activity);
          switch (subscribeResult) {
            case Ok():
              return Result.ok(null);
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
  Future<Result<void>> sendFeedback({required Activity activity, required String comment}) async {
    try {
      final subscribeResult = await _databaseService.sendFeedback(activityId: activity.id, comment: comment);
      switch (subscribeResult) {
        case Ok():
          return Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }
}