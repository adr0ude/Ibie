import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibie/models/summary_activity.dart';

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

  Future<Result<void>> updateUserData(User user) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(user.id);

      final userDocSnapshot = await userRef.get();
      if (!userDocSnapshot.exists) {
        return Result.error(Exception("Usuário não encontrado"));
      }

      await userRef.update(user.toMap());
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao atualizar dados do usuário"));
    }
  }

  Future<Result<void>> createActivity(Activity activity) async {
    try {
      await _firestore.collection('courses').add(activity.toMap());
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao criar atividade: $e'));
    }
  }

  Future<Result<List<Activity>>> getActivities() async {
    try {
      final querySnapshot = await _firestore.collection('courses').get();
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
          .collection('courses')
          .doc(activity.id)
          .update(activity.toMap());
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao atualizar atividade: $e'));
    }
  }

  Future<Result<void>> deleteActivity(String activityId) async {
    try {
      await _firestore.collection('courses').doc(activityId).delete();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao excluir atividade: $e'));
    }
  }

  Future<Result<List<SummaryActivity>>> getMyActivities(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .get();

      final activities = querySnapshot.docs
          .map((doc) => SummaryActivity.fromMap(doc.data(), doc.id))
          .toList();

      return Result.ok(activities);
    } catch (e) {
      return Result.error(
        Exception('Não foi possível carregar suas atividades'),
      );
    }
  }

  Future<Result<Activity>> getActivityData(String activityId) async {
    try {
      final doc = await _firestore.collection('courses').doc(activityId).get();
      if (doc.exists) {
        final activity = Activity.fromMap(doc.data()!, doc.id);
        return Result.ok(activity);
      } else {
        return Result.error(
          Exception("Os dados do curso não foram encontrados"),
        );
      }
    } catch (e) {
      return Result.error(
        Exception('Não foi possível carregar os dados da atividade'),
      );
    }
  }

  Future<Result<void>> subscribe(User user, Activity activity) async {
    try {
      // adicionar o aluno na subcoleção 'students' da atividade
      final studentRef = _firestore
          .collection('courses')
          .doc(activity.id)
          .collection('students')
          .doc(user.id);

      await studentRef.set({'userName': user.name}); // nome do aluno

      // adicionar a atividade na subcoleção 'courses' do usuário
      final userCourseRef = _firestore
          .collection('users')
          .doc(user.id)
          .collection('courses')
          .doc(activity.id);

      await userCourseRef.set({
        'userId': activity.userId, // id do professor
        'userName': activity.userName, // nome do professor
        'title': activity.title,
        'image': activity.image,
        'status': 'ativa',
      });

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao realizar inscrição'));
    }
  }

  Future<Result<void>> unsubscribe(User user, Activity activity) async {
    try {
      // remover o aluno da subcoleção 'students' da atividade
      final studentRef = _firestore
          .collection('courses')
          .doc(activity.id)
          .collection('students')
          .doc(user.id);

      await studentRef.delete();

      // atualizar o status da atividade na subcoleção 'courses' do usuário
      final userCourseRef = _firestore
          .collection('users')
          .doc(user.id)
          .collection('courses')
          .doc(activity.id);

      await userCourseRef.update({'status': 'cancelada'});

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('O cancelamento falhou'));
    }
  }

  Future<Result<void>> sendFeedback(String activityId, String comment) async {
    try {
      final courseRef = _firestore.collection('courses').doc(activityId);

      await courseRef.update({
        'comments': FieldValue.arrayUnion([comment]),
      });

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('O envio do comentário falhou'));
    }
  }
}