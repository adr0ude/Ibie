import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/activity_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/models/activity.dart';
import 'package:ibie/models/activity_category.dart';
import 'package:ibie/utils/results.dart';

class ActivityFormViewModel extends ChangeNotifier {
  final IActivityRepository _activityRepository;
  final IUserRepository _userRepository;

  ActivityFormViewModel({
    required IActivityRepository activityRepository,
    required IUserRepository userRepository,
  }) : _activityRepository = activityRepository,
       _userRepository = userRepository;

  String _id = '';
  String _title = '';
  String _description = '';
  String _category = '';
  String _targetAudience = '';
  String _date = '';
  String _time = '';
  String _location = '';
  String _street = '';
  String _number = '';
  String _neighborhood = '';
  String _city = '';
  String _cep = '';
  String _vacancies = '';
  String _fee = '';
  String _accessibilityDescription = '';
  String _image = '';
  String _accessibilityResources = '';
  int _currentPage = 0;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String get city => _city;
  int get currentPage => _currentPage;

  void goToNextPage() {
    if (_currentPage < 2) {
      _currentPage++;
      notifyListeners();
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  List<ActivityCategory> get availableCategories => defaultCategories;
  String get selectedCategory => _category;
  String get selectedAccessibility => _accessibilityResources;

  bool get isEditing => _id.isNotEmpty;

  set title(String value) => _title = value.trim();
  set description(String value) => _description = value.trim();
  set category(String value) {
    _category = value;
    notifyListeners();
  }

  set targetAudience(String value) => _targetAudience = value.trim();
  set date(String value) => _date = value.trim();
  set time(String value) => _time = value.trim();
  set location(String value) => _location = value.trim();
  set street(String value) => _street = value.trim();
  set number(String value) => _number = value.trim();
  set neighborhood(String value) => _neighborhood = value.trim();
  set city(String value) => _city = value.trim();
  set cep(String value) => _cep = value.trim();
  set vacancies(String value) => _vacancies = value.trim();
  set fee(String value) => _fee = value.trim();
  set image(String value) => _image = value.trim();
  set accessibilityResources(String value) =>
      _accessibilityResources = value.trim();
  set accessibilityDescription(String value) =>
      _accessibilityDescription = value.trim();

  bool isValidDate(String input) {
    final parsed = DateTime.tryParse(input);
    return parsed != null;
  }

/*
  bool get isFormValid =>
      _title.isNotEmpty &&
      _description.isNotEmpty &&
      _category.isNotEmpty &&
      _date.isNotEmpty &&
      _time.isNotEmpty &&
      _location.isNotEmpty &&
      _street.isNotEmpty &&
      _neighborhood.isNotEmpty &&
      _city.isNotEmpty &&
      _cep.isNotEmpty &&
      _targetAudience.isNotEmpty &&
      _image.isNotEmpty &&
      _vacancies.isNotEmpty &&
      _accessibilityDescription.isNotEmpty &&
      _accessibilityResources.isNotEmpty;

*/
  void loadActivity(Activity activity) {
    _id = activity.id;
    _title = activity.title;
    _description = activity.description;
    _category = activity.category;
    _targetAudience = activity.targetAudience;
    _date = activity.date;
    _time = activity.time;
    _location = activity.location;
    _street = activity.street;
    _number = activity.number;
    _neighborhood = activity.neighborhood;
    _city = activity.city;
    _cep = activity.cep;
    _vacancies = activity.vacancies;
    _fee = activity.fee;
    _accessibilityResources = activity.accessibilityResources;
    _accessibilityDescription = activity.accessibilityDescription;

    notifyListeners();
  }

  Future<Result<void>> submitForm() async {
    /*
    if (!isFormValid) {
      return Result.error(Exception("Preencha todos os campos obrigatórios"));
    }
    */

    _isLoading = true;
    notifyListeners();

    try {
      final userResult = await _userRepository.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          if (user.type != 'instructor') {
            return Result.error(
              Exception(
                "Apenas instrutores podem cadastrar ou editar atividades.",
              ),
            );
          }

          final activity = Activity(
            id: _id,
            userId: user.id,
            userName: user.name,
            title: _title,
            description: _description,
            category: _category,
            targetAudience: _targetAudience,
            date: _date,
            time: _time,
            location: _location,
            street: _street,
            number: _number,
            neighborhood: _neighborhood,
            city: _city,
            cep: _cep,
            vacancies: _vacancies,
            fee: _fee,
            accessibilityResources: _accessibilityResources,
            accessibilityDescription: _accessibilityDescription,
            comments: [],
            image: _image,
            status: 'active',
          );

          if (isEditing) {
            return await _activityRepository.updateActivity(activity: activity);
          } else {
            return await _activityRepository.createActivity(activity: activity);
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
