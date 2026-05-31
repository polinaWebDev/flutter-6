import 'package:firebase_auth/firebase_auth.dart';

//своё исключение
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

//обёртка над FirebaseAuth
class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //firebase сам хранит сессию между запусками - отсюда стартовое состояние
  User? get currentUser => _auth.currentUser;

  //стрим событий входа/выхода для вьюмодели
  Stream<User?> authChanges() => _auth.authStateChanges();

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  Future<void> signOut() => _auth.signOut();

  //коды ошибок firebase в понятный текст
  String _mapError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Этот email уже занят';
      case 'invalid-email':
        return 'Некорректный email';
      case 'weak-password':
        return 'Слишком простой пароль (минимум 6 символов)';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Неверный email или пароль';
      case 'user-disabled':
        return 'Аккаунт заблокирован';
      case 'too-many-requests':
        return 'Слишком много попыток, попробуйте позже';
      case 'network-request-failed':
        return 'Нет соединения с сетью';
      default:
        return 'Не удалось выполнить запрос. Попробуйте ещё раз';
    }
  }
}
