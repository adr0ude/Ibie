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
      return Result.error(Exception('O cadastro da atividade falhou'));
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
        .where((activity) {
          final remaining = int.tryParse(activity.remainingVacancies.isEmpty ? '0' : activity.remainingVacancies) ?? 0;
          return remaining > 0;
        })
        .toList();
      
      return Result.ok(activities);
    } catch (e) {
      return Result.error(Exception('Erro ao carregar atividades'));
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
      return Result.error(Exception('A edição da atividade falhou'));
    }
  }

  Future<Result<void>> deleteActivity({required String activityId}) async {
    try {
      // buscar todos os usuários
      final usersSnapshot = await _firestore.collection('users').get();

      for (final userDoc in usersSnapshot.docs) {
        final userId = userDoc.id;

        // referência para o documento na subcoleção 'courses' do usuário
        final userCourseRef = _firestore
            .collection('users')
            .doc(userId)
            .collection('enrolled_courses')
            .doc(activityId);

        final userCourseDoc = await userCourseRef.get();

        // se existir, deletar
        if (userCourseDoc.exists) {
          await userCourseRef.delete();
        }
      }

      // deletar a atividade principal
      await _firestore.collection('courses').doc(activityId).delete();

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('A exclusão da atividade falhou'));
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

      if (!instructorDoc.exists) {
        return Result.error(Exception('Usuário não encontrado'));
      }

      final data = instructorDoc.data()!;
      
      // verifica se o usuário é um instrutor
      if (data['type']?.toLowerCase() != 'instructor') {
        return Result.error(Exception('O usuário não é um instrutor'));
      }

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
      final docRef = _firestore.collection('courses').doc(activity.id);

      // busca o documento para checar vagas
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return Result.error(Exception('Atividade não encontrada'));
      }

      final data = docSnap.data()!;
      final remainingVacanciesStr = data['remainingVacancies'] ?? '';
      final remainingVacancies = remainingVacanciesStr.isEmpty
          ? 0
          : int.tryParse(remainingVacanciesStr) ?? 0;

      if (remainingVacancies <= 0) {
        return Result.error(Exception('Não há vagas disponíveis'));
      }

      // transação para evitar condições de corrida
      await _firestore.runTransaction((transaction) async {
        final freshSnap = await transaction.get(docRef);
        final freshData = freshSnap.data()!;
        final currentVacanciesStr = freshData['remainingVacancies'] ?? '';
        final currentVacancies = currentVacanciesStr.isEmpty
            ? 0
            : int.tryParse(currentVacanciesStr) ?? 0;

        if (currentVacancies <= 0) {
          throw Exception('Não há vagas disponíveis');
        }

        // atualiza o número de vagas e adiciona aluno na lista
        transaction.update(docRef, {
          'remainingVacancies': (currentVacancies - 1).toString(),
          'students': FieldValue.arrayUnion([user.id]),
        });

        // adiciona a inscrição do usuário
        final userCourseRef = _firestore
            .collection('users')
            .doc(user.id)
            .collection('enrolled_courses')
            .doc(activity.id);

        transaction.set(userCourseRef, {
          'userId': activity.userId,
          'status': 'active',
        });
      });

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao realizar inscrição'));
    }
  }

  Future<Result<void>> unsubscribe({required User user, required Activity activity}) async {
    try {
      final docRef = _firestore.collection('courses').doc(activity.id);

      await _firestore.runTransaction((transaction) async {
        final docSnap = await transaction.get(docRef);

        if (!docSnap.exists) {
          throw Exception('Atividade não encontrada');
        }

        final data = docSnap.data()!;
        final remainingVacanciesStr = data['remainingVacancies'] ?? '';
        final remainingVacancies = remainingVacanciesStr.isEmpty
            ? 0
            : int.tryParse(remainingVacanciesStr) ?? 0;

        // incrementa 1 vaga
        final newRemaining = remainingVacancies + 1;

        // atualiza vagas e remove aluno da lista
        transaction.update(docRef, {
          'remainingVacancies': newRemaining.toString(),
          'students': FieldValue.arrayRemove([user.id]),
        });

        // atualiza status no usuário
        final userCourseRef = _firestore
            .collection('users')
            .doc(user.id)
            .collection('enrolled_courses')
            .doc(activity.id);

        transaction.update(userCourseRef, {'status': 'canceled'});
      });

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

  Future<Result<List<String>>> getStudentsNames({required String activityId}) async {
    try {
      final activityDoc = await _firestore
          .collection('courses')
          .doc(activityId)
          .get();

      if (!activityDoc.exists) {
        return Result.error(Exception('Atividade não encontrada'));
      }

      final ids = List<String>.from(activityDoc.data()?['students'] ?? []);

      final futures = ids.map((id) async {
        final userDoc = await _firestore.collection('users').doc(id).get();
        if (!userDoc.exists) {
          return 'Desconhecido';
        }
        final data = userDoc.data()!;
        return data['name'] as String;
      });

      final names = await Future.wait(futures);

      return Result.ok(names);
    } catch (e) {
      return Result.error(
        Exception('Não foi possível carregar os nomes dos alunos'),
      );
    }
  }
}