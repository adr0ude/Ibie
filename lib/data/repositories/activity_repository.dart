import 'package:flutter/material.dart';
import 'package:ibie/data/services/image_service.dart';

import 'package:ibie/models/activity.dart';
import 'package:ibie/models/enrolled_activity.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:ibie/data/services/shared_preferences_service.dart';
import 'package:ibie/data/services/storage_service.dart';

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
  Future<Result<void>> deleteActivityImage({required Activity activity});
  Future<Result<String?>> pickActivityImage({required String source});
  Future<Result<void>> updateActivityData({required Activity activity, String? newPhoto});
  Future<Result<List<String>>> getStudentsNames({required String activityId});
}

class ActivityRepository extends IActivityRepository {
  final DatabaseService _databaseService;
  final SharedPreferencesService _preferencesService;
  final StorageService _storageService;
  final ImageService _imageService;

  ActivityRepository({
    required DatabaseService databaseService,
    required SharedPreferencesService preferencesService,
    required StorageService storageService,
    required ImageService imageService,
  }) : _databaseService = databaseService,
       _preferencesService = preferencesService,
       _storageService = storageService,
       _imageService = imageService;

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
    try {
      final deleteResult = await _databaseService.deleteActivity(activityId: activityId);
      switch (deleteResult) {
        case Ok():
          return Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
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

  @override
  Future<Result<void>> updateActivityData({required Activity activity, String? newPhoto}) async {
    try {
      if (newPhoto != null) {
        // se há uma nova foto
        if (activity.image.isNotEmpty) {
          // se já havia uma foto
          final deleteResult = await _storageService.deleteActivityImage(
            imageUrl: newPhoto,
          ); // deleta a antiga
          switch (deleteResult) {
            case Ok():
              break;
            case Error(error: final e):
              return Result.error(e);
          }
        }
        final imageResult = await _storageService.uploadActivityImage(
          imagePath: newPhoto,
        ); // upload da nova
        switch (imageResult) {
          case Ok(value: final imageUrl):
            activity = activity.copyWith(image: imageUrl);
            break;
          case Error(error: final e):
            return Result.error(e);
        }
      }

      if (newPhoto != null) {
        // se há uma nova foto
        if (newPhoto.isEmpty && activity.image.isNotEmpty) {
          // ela é vazia e a antiga não
          final deleteResult = await _storageService.deleteActivityImage(
            imageUrl: newPhoto,
          ); // deleta a antiga
          switch (deleteResult) {
            case Ok():
              break;
            case Error(error: final e):
              return Result.error(e);
          }
          activity = activity.copyWith(image: '');
        }
      }

      final databaseResult = await _databaseService.updateActivity(
        activity: activity,
      );
      switch (databaseResult) {
        case Ok():
          return const Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> deleteActivityImage({required Activity activity}) async {
    try {
      final deleteResult = await _storageService.deleteActivityImage(
        imageUrl: activity.image,
      ); // deleta a antiga
      switch (deleteResult) {
        case Ok():
          activity = activity.copyWith(image: '');
          final databaseResult = await _databaseService.updateActivity(
            activity: activity,
          );

          switch (databaseResult) {
            case Ok():
              return const Result.ok(null);
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
  Future<Result<String?>> pickActivityImage({required String source}) async {
    try {
      Result<String?> imageResult;

      if (source == 'camera') {
        imageResult = await _imageService.pickImageFromCamera();
      } else if (source == 'gallery') {
        imageResult = await _imageService.pickImageFromGallery();
      } else {
        return Result.error(Exception('Fonte inválida'));
      }

      switch (imageResult) {
        case Ok(value: final newImage):
          if (newImage != null) {
            final urlResult = await _storageService.uploadActivityImage(
              imagePath: newImage,
            );
            return urlResult;
          } else {
            return Result.ok(null);
          }
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<String>>> getStudentsNames({required String activityId}) async {
    try {
      final listResult = await _databaseService.getStudentsNames(activityId: activityId);
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
}