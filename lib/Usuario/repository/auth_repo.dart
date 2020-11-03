import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'auth_api.dart';

class AuthRepo {
  static final _authAPI = AuthAPI();

  Future<auth.UserCredential> signInWithGoogle() => _authAPI.signInWithGoogle();

  signOut() => _authAPI.signOut();

  Future<auth.UserCredential> signInWithEmailAndPassword(
          String email, String password, BuildContext context) =>
      _authAPI.signInWithEmailAndPassword(email, password, context);

  auth.User getCurrentUser() => _authAPI.getCurrentUser();

  Future<bool> autenticarUsuario( String email, String contrasena)=> _authAPI.autenticarUsuario(email, contrasena);
}
