import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/firebase_auth_messages.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<Result<String>> getUserUid() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        return Result.ok(user.uid);
      } else {
        return Result.error(Exception("Nenhum usuário está autenticado"));
      }
    } catch (e) {
      return Result.error(Exception("Erro ao acessar o UID do usuário"));
    }
  }

  Future<Result<User>> signUpEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.ok(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(Exception(getFirebaseAuthErrorMessage(e.code)));
    } catch (e) {
      return Result.error(Exception("Erro ao cadastrar usando o e-mail"));
    }
  }

  Future<Result<User>> loginEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.ok(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(Exception(getFirebaseAuthErrorMessage(e.code)));
    } catch (e) {
      return Result.error(Exception("Erro ao entrar com o e-mail"));
    }
  }

  Future<Result<UserCredential>> signUpGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Result.error(Exception("Login cancelado"));
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return Result.ok(userCredential);
    } on FirebaseAuthException catch (e) {
      return Result.error(Exception(getFirebaseAuthErrorMessage(e.code)));
    } catch (e) {
      return Result.error(Exception("Erro ao entrar usando o Google"));
    }
  }

  Future<Result<void>> sendPasswordResetEmail(String email) async {
    _firebaseAuth.setLanguageCode("pt");
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(
        Exception("Erro ao enviar email de redefinição de senha"),
      );
    }
  }
}
