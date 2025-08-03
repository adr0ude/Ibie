import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ibie/models/user.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/models/atividades_cards.dart';

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

  Future<List<Atividade>> buscarAtividades() async {
    final snapshot = await _firestore.collection('courses').get();
    
    return snapshot.docs.map((doc) {

      final data = doc.data();
      
      return Atividade(
        categoria: data['categoria'],
        titulo: data['titulo'],
        professor: data['professor_name'],
        dataHora: data['dataHora'],
        local: data['local'],
        imagem: data['imagem'] ?? '',
        preco: data['preco'],
      );
    }).toList();
  }
}
