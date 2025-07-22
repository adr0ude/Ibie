import 'package:shared_preferences/shared_preferences.dart';

import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';

class SharedPreferencesService {
  static const _keyId = 'userId';
  static const _keyType = 'userType';
  static const _keyName = 'userName';
  static const _keyPhoto = 'userPhoto';
  static const _keyCPF = 'userCPF';
  static const _keyDateBirth = 'userDateBirth';
  static const _keyCity = 'useraCity';
  static const _keyPhone = 'userPhone';
  static const _keyEmail = 'userEmail';
  static const _keyPassword = 'userPassword';

  final Future<SharedPreferences> _preferences;

  SharedPreferencesService({Future<SharedPreferences>? preferences})
      : _preferences = preferences ?? SharedPreferences.getInstance();

  Future<Result<void>> saveUserData({required User user}) async {
    final preferences = await _preferences;

    try {
      await preferences.setString(_keyId, user.id);
      await preferences.setString(_keyType, user.type);
      await preferences.setString(_keyName, user.name);
      await preferences.setString(_keyPhoto, user.photo);
      await preferences.setString(_keyCPF, user.cpf);
      await preferences.setString(_keyDateBirth, user.dateBirth);
      await preferences.setString(_keyCity, user.city);
      await preferences.setString(_keyPhone, user.phone);
      await preferences.setString(_keyEmail, user.email);
      await preferences.setString(_keyPassword, user.password);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao salvar os dados localmente"));
    }
  }

  Future<Result<User>> getUserData() async {
    try {
      final preferences = await _preferences;

      final id = preferences.getString(_keyId);
      final type = preferences.getString(_keyType);
      final name = preferences.getString(_keyName);
      final photo = preferences.getString(_keyPhoto);
      final cpf = preferences.getString(_keyCPF);
      final dateBirth = preferences.getString(_keyDateBirth);
      final city = preferences.getString(_keyCity);
      final phone = preferences.getString(_keyPhone);
      final email = preferences.getString(_keyEmail);
      final password = preferences.getString(_keyPassword);
      

      final User user = User(
        id: id ?? '',
        type: type ?? '',
        name: name ?? '',
        photo: photo ?? '',
        cpf: cpf ?? '',
        dateBirth: dateBirth ?? '',
        city: city ?? '',
        phone: phone ?? '',
        email: email ?? '',
        password: password ?? '',
      );

      return Result.ok(user);
    } catch (e) {
      return Result.error(Exception("Erro ao acessar os dados localmente"));
    }
  }

  Future<Result<void>> clearUserData() async {
    try {
      final preferences = await _preferences;
      await preferences.clear();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao limpar os dados localmente"));
    }
  }
}