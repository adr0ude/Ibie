import 'package:flutter/material.dart';

import 'package:ibie/models/activity.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/data/services/database_service.dart';

abstract class IActivityRepository extends ChangeNotifier {
  Future<Result<void>> createActivity(Activity activity);
  Future<Result<List<Activity>>> getActivities();
  Future<Result<void>> updateActivity(Activity activity);
  Future<Result<void>> deleteActivity(String activityId);
}

class ActivityRepository extends IActivityRepository {
  final DatabaseService _databaseService;

  ActivityRepository({required DatabaseService databaseService})
    : _databaseService = databaseService;

  @override
  Future<Result<void>> createActivity(Activity activity) async {
    final result = await _databaseService.createActivity(activity);
    notifyListeners();
    return result;
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
}
