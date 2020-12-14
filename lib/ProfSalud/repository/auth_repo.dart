import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'auth_api.dart';

class AuthRepo {
  static final _authAPI = AuthAPI();

  Future<auth.UserCredential> signInWithGoogle() => _authAPI.signInWithGoogle();
  
  /// Cierra sesión del usuario actual loggeado, de todas las plataformas en las que este Loggeado Ej: Google,Facebook...etc.
  signOut() => _authAPI.signOut();

  /// Inicia sesión al usuario con los cuales el email y contraseña coincidan., retorna una instancia de Usuario de Firebase Auth.
  Future<auth.UserCredential> signInWithEmailAndPassword(
          String email, String password, BuildContext context) =>
      _authAPI.signInWithEmailAndPassword(email, password, context);
  
  /// Retorna la instancia del usuario actualmente loggeado.
  auth.User getCurrentUser() => _authAPI.getCurrentUser();
}
