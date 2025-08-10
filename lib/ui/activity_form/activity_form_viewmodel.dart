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
  String get image => _image;

  bool get isEditing => _id.isNotEmpty;

  set title(String value) => _title = value.trim();
  set description(String value) => _description = value.trim();
  set category(String value) => _category = value.trim();
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

  Future<Result<void>> pickImage(String source) async {
    try {
      _isLoading = true;
      notifyListeners();
      final photoResult = await _activityRepository.pickActivityImage(
        source: source,
      );

      switch (photoResult) {
        case Ok(value: final picture):
          _image = picture!;
          return const Result.ok(null);
        case Error(error: final e):
          return Result.error(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Result<void>> submitForm() async {
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
            remainingVacancies: _vacancies,
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

  String? validateDate(String date) {
    if (date.trim().isEmpty) return 'Informe uma data.';

    final parts = date.split('/');
    if (parts.length != 3) return 'Informe uma data válida.';

    try {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final parsedDate = DateTime(year, month, day);

      if (parsedDate.day != day ||
          parsedDate.month != month ||
          parsedDate.year != year) {
        return 'Informe uma data válida.';
      }

      if (parsedDate.isBefore(DateTime.now())) {
        return 'Informe uma data futura.';
      }

      return null;
    } catch (_) {
      return 'Insira uma data válida';
    }
  }

  String? validateTime(String time) {
    if (time.trim().isEmpty) return 'Informe um horário.';

    final parts = time.split(':');
    if (parts.length != 2) return 'Informe um horário válido.';

    try {
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      if (hour < 0 || hour > 23) return 'Hora inválida.';
      if (minute < 0 || minute > 59) return 'Minutos inválidos.';

      return null;
    } catch (_) {
      return 'Informe um horário válido.';
    }
  }

  String? validateCep(String cep) {
    if (cep.trim().isEmpty) return 'Informe o CEP.';

    final cepRegex = RegExp(r'^\d{5}-\d{3}$');
    if (!cepRegex.hasMatch(cep)) {
      return 'Informe um CEP válido.';
    }

    return null;
  }
}