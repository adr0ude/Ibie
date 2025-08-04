import 'package:flutter/material.dart';
import 'package:ibie/data/services/shared_preferences_service.dart';

import 'package:ibie/models/activity.dart';
import 'package:ibie/models/summary_activity.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/data/services/database_service.dart';

abstract class IActivityRepository extends ChangeNotifier {
  Future<Result<void>> createActivity(Activity activity);
  Future<Result<List<Activity>>> getActivities();
  Future<Result<void>> updateActivity(Activity activity);
  Future<Result<void>> deleteActivity(String activityId);
  Future<Result<List<SummaryActivity>>> getMyActivities();
  Future<Result<Activity>> getActivityData({required String activityId});
  Future<Result<void>> subscribe({required Activity activity});
  Future<Result<void>> unsubscribe({required Activity activity});
  Future<Result<void>> sendFeedback({
    required Activity activity,
    required String comment,
  });
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
  Future<Result<void>> createActivity(Activity activity) async {
    try {
      final userResult = await _preferencesService.getUserData();

      switch (userResult) {
        case Ok(value: final user):
          final updatedActivity = activity.copyWith(
            userId: user.id,
            userName: user.name,
          );

          final result = await _databaseService.createActivity(updatedActivity);
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
    final result = await _databaseService.getActivities();
    notifyListeners();
    return result;
  }

  @override
  Future<Result<void>> updateActivity(Activity activity) async {
    final result = await _databaseService.updateActivity(activity);
    notifyListeners();
    return result;
  }

  @override
  Future<Result<void>> deleteActivity(String activityId) async {
    final result = await _databaseService.deleteActivity(activityId);
    notifyListeners();
    return result;
  }

  @override
  Future<Result<List<SummaryActivity>>> getMyActivities() async {
    try {
      final userResult = await _preferencesService.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          final listResult = await _databaseService.getMyActivities(user.id);
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
  Future<Result<Activity>> getActivityData({required String activityId}) async {
    try {
      final activityResult = await _databaseService.getActivityData(activityId);
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
  Future<Result<void>> subscribe({required Activity activity}) async {
    try {
      final userResult = await _preferencesService.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          final subscribeResult = await _databaseService.subscribe(
            user,
            activity,
          );
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
          final subscribeResult = await _databaseService.unsubscribe(
            user,
            activity,
          );
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
  Future<Result<void>> sendFeedback({
    required Activity activity,
    required String comment,
  }) async {
    try {
      final subscribeResult = await _databaseService.sendFeedback(activity.id, comment);
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
