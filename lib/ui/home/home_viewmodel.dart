import 'package:flutter/material.dart';

import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/models/atividades_cards.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel({
    required IUserRepository userRepository,
    required DatabaseService databaseService,
  }) : _userRepository = userRepository,
       _databaseService = databaseService;

  final IUserRepository _userRepository;
  final DatabaseService _databaseService;

  bool _isLoading = false;
  User? _user;

  List<Atividade> _atividades = [];
  List<Atividade> get atividade => _atividades;

  bool get isLoading => _isLoading;
  User? get user => _user;
  String get name => _user?.name ?? '';
  String get type => _user?.type ?? '';
  String get photo => _user?.photo ?? '';

  // Carregar dados do usuário, os cursos...
  Future<Result<void>> init() async {
    try {
      _isLoading = true;
      final userResult = await _userRepository.getUserData();
      switch (userResult) {
        case Ok(value: final user):
          _user = user;
          break;
        case Error(error: final e):
          return Result.error(e);
      }

      _atividades = await _databaseService.buscarAtividades();
      return Result.ok(null);

    } catch (e) { 
      return Result.error(Exception('Erro ao carregar dados'));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}