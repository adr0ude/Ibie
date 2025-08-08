import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ibie/models/user.dart';
import 'package:ibie/models/activity.dart';
import 'package:ibie/models/enrolled_activity.dart';

import 'package:ibie/utils/results.dart';

class DatabaseService {
  final FirebaseFirestore _firestore;

  DatabaseService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Result<User>> fetchUserData({required String userId}) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

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

  Future<Result<void>> setUserData({required User user}) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .set(user.toMap());

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao salvar os dados do usuário"));
    }
  }

  Future<Result<void>> registerCategories({required String userId, required List<String> categories}) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
            'categories': categories,
          });

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao salvar as categorias do usuário"));
    }
  }

  Future<Result<void>> updateUserData({required User user}) async {
    try {
      final userRef = _firestore.collection('users').doc(user.id);

      final doc = await userRef.get();
      if (!doc.exists) {
        return Result.error(Exception("Usuário não encontrado"));
      }

      await userRef.update(user.toMap());
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Erro ao atualizar dados do usuário"));
    }
  }

  Future<Result<void>> createActivity({required Activity activity}) async {
    try {
      await _firestore
          .collection('courses')
          .add(activity.toMap());

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao criar atividade: $e'));
    }
  }

  Future<Result<List<Activity>>> getActivitiesHome() async {
    try {
      final querySnapshot = await _firestore
          .collection('courses')
          .where('status', isEqualTo: 'active')
          .get();

      final activities = querySnapshot.docs
          .map((doc) => Activity.fromMap(doc.data(), doc.id))
          .toList();
      return Result.ok(activities);
    } catch (e) {
      return Result.error(Exception('Erro ao buscar atividades: $e'));
    }
  }

  Future<Result<void>> updateActivity({required Activity activity}) async {
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

  Future<Result<void>> deleteActivity({required String activityId}) async {
    try {
      await _firestore.collection('courses')
          .doc(activityId)
          .delete();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao excluir atividade: $e'));
    }
  }

  Future<Result<List<EnrolledActivity>>> getEnrolledActivities({required String userId}) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('enrolled_courses')
          .get();

      final enrolledActivities = <EnrolledActivity>[];

      for (final doc in querySnapshot.docs) {
        final activityId = doc.id;
        final status = doc.data()['status'];

        final activityDoc = await _firestore
            .collection('courses')
            .doc(activityId)
            .get();

        if (activityDoc.exists) {
          final activity = Activity.fromMap(
            activityDoc.data()!,
            activityDoc.id,
          );
          enrolledActivities.add(EnrolledActivity(activity: activity, status: status));
        }
      }

      return Result.ok(enrolledActivities);
    } catch (e) {
      return Result.error(Exception('Não foi possível carregar suas atividades inscritas'),
      );
    }
  }

  Future<Result<List<Activity>>> getInstructorActivities({required String instructorId}) async {
    try {
      final instructorDoc = await _firestore
          .collection('users')
          .doc(instructorId)
          .get();

      final myCourses = List<String>.from(instructorDoc.data()?['my_courses'] ?? []);

      final activities = <Activity>[];

      for (final activityId in myCourses) {
        final activityDoc = await _firestore
            .collection('courses')
            .doc(activityId)
            .get();

        if (activityDoc.exists) {
          final data = activityDoc.data()!;
          if (data['status'] == 'active') {
            final activity = Activity.fromMap(data, activityDoc.id);
            activities.add(activity);
          }
        }
      }

      return Result.ok(activities);
    } catch (e) {
      return Result.error(
        Exception('Não foi possível carregar as atividades do instrutor'),
      );
    }
  }

  Future<Result<Activity>> getActivityData({required String activityId}) async {
    try {
      final doc = await _firestore
          .collection('courses')
          .doc(activityId)
          .get();

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

  Future<Result<User>> getInstructorData({required String instructorId}) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(instructorId)
          .get();
          
      if (doc.exists) {
        final instructor = User.fromMap(doc.data()!, doc.id);
        return Result.ok(instructor);
      } else {
        return Result.error(
          Exception("Os dados do instrutor não foram encontrados"),
        );
      }
    } catch (e) {
      return Result.error(
        Exception('Não foi possível carregar os dados do instrutor'),
      );
    }
  }

  Future<Result<void>> subscribe({required User user, required Activity activity}) async {
    try {
      // adicionar o aluno na lista de 'students' da atividade
      await _firestore
          .collection('courses')
          .doc(activity.id)
          .update({
            'students': FieldValue.arrayUnion([user.id]),
          });

      // adicionar a atividade na subcoleção 'courses' do usuário
      await _firestore
          .collection('users')
          .doc(user.id)
          .collection('enrolled_courses')
          .doc(activity.id)
          .set({
            'userId': activity.userId, // id do professor
            'status': 'active', // status de inscrição
          });

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao realizar inscrição'));
    }
  }

  Future<Result<void>> unsubscribe({required User user, required Activity activity}) async {
    try {
      // remover o aluno na lista de 'students' da atividade
      await _firestore
          .collection('courses')
          .doc(activity.id)
          .update({
            'students': FieldValue.arrayRemove([user.id]),
          });

      // atualizar o status da atividade na subcoleção 'courses' do usuário
      await _firestore
          .collection('users')
          .doc(user.id)
          .collection('enrolled_courses')
          .doc(activity.id)
          .update({'status': 'canceled'});

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('O cancelamento falhou'));
    }
  }

  Future<Result<void>> sendFeedback({required String activityId, required String comment}) async {
    try {
      await _firestore
          .collection('courses')
          .doc(activityId)
          .update({
            'comments': FieldValue.arrayUnion([comment]),
          });

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('O envio do comentário falhou'));
    }
  }
}