import 'package:flutter/material.dart';
import 'package:ibie/data/repositories/activity_repository.dart';
import 'package:ibie/models/activity.dart';

import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

class InstructorDetailsViewModel extends ChangeNotifier {
  InstructorDetailsViewModel({
    required IActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  final IActivityRepository _activityRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _instructor;
  User? get instructor => _instructor;

  String get name => _instructor?.name ?? '';
  String get biography => _instructor?.biography ?? '';
  String get phone => _instructor?.phone ?? '';
  String get photo => _instructor?.photo ?? '';

  List<Activity> _activities = [];
  List<Activity> get activities => _activities;

  Future<Result<void>> init(String instructorId) async {
    try {
      _isLoading = true;

      final userResult = await _activityRepository.getInstructorData(instructorId: instructorId); // pegar os dados da atividade
      switch (userResult) {
        case Ok(value: final instructor):
          _instructor = instructor;
          final activitiesResult = await _activityRepository.getInstructorActivities(instructorId: _instructor!.id); // pegar a lista de atividades onde aquele é o isntrutor
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
}