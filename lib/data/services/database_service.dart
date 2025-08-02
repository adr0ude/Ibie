import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ibie/models/user.dart';
import 'package:ibie/models/activity.dart';
import 'package:ibie/utils/results.dart';

class DatabaseService {
  final FirebaseFirestore _firestore;

  DatabaseService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Result<User>> fetchUserData(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final user = User.fromMap(doc.data()!, doc.id);
        return Result.ok(user);
      } else {
        return Result.error(
          Exception("Os dados do usuário não foram encontrados"),
        );
      }
    } catch (e) {
      return Result.error(Exception("Erro ao acessar os dados do usuário"));
    }
  }

  Future<Result<void>> setUserData(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao salvar os dados do usuário"));
    }
  }

  Future<Result<void>> registerCategories(
    String userId,
    List<String> categories,
  ) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'categories': categories,
      });

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao salvar as categorias do usuário"));
    }
  }

  Future<Result<void>> createActivity(Activity activity) async {
    try {
      await _firestore.collection('activities').add(activity.toMap());
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao criar atividade: $e'));
    }
  }

  Future<Result<List<Activity>>> getActivities() async {
    try {
      final querySnapshot = await _firestore.collection('activities').get();
      final activities = querySnapshot.docs
          .map((doc) => Activity.fromMap(doc.data(), doc.id))
          .toList();
      return Result.ok(activities);
    } catch (e) {
      return Result.error(Exception('Erro ao buscar atividades: $e'));
    }
  }

  Future<Result<void>> updateActivity(Activity activity) async {
    try {
      await _firestore
          .collection('activities')
          .doc(activity.id)
          .update(activity.toMap());
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao atualizar atividade: $e'));
    }
  }

  Future<Result<void>> deleteActivity(String activityId) async {
    try {
      await _firestore.collection('activities').doc(activityId).delete();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao excluir atividade: $e'));
    }
  }
}
