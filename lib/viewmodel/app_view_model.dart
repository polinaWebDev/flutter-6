import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';

//три состояния: загрузка, гость, и вошедший
enum AuthStatus { loading, unauthenticated, authenticated }

//состояние авторизации для всего приложения
class AppViewModel extends ChangeNotifier {
  final AuthRepository _auth;

  StreamSubscription<User?>? _sub;

  AuthStatus _status = AuthStatus.loading;
  String _email = '';

  AppViewModel(this._auth) {
    //подписка на вход/выход, сессию firebase восстанавливает сам при старте
    _sub = _auth.authChanges().listen(_onAuthChanged);
  }

  AuthStatus get status => _status;
  String get email => _email;
  bool get isAuthorized => _status == AuthStatus.authenticated;

  void _onAuthChanged(User? user) {
    if (user == null) {
      _status = AuthStatus.unauthenticated;
      _email = '';
    } else {
      _status = AuthStatus.authenticated;
      _email = user.email ?? '';
    }
    notifyListeners();
  }

  //при ошибке летит AuthException, её ловит экран входа
  Future<void> signIn(String email, String password) => _auth.signIn(email, password);

  Future<void> register(String email, String password) => _auth.register(email, password);

  Future<void> logout() => _auth.signOut();

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
