import 'package:PsyBrain/User/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
  final _auth_repo = AuthRepo();

  Stream<auth.User> userStream = auth.FirebaseAuth.instance.authStateChanges();

  //Caso de uso: Inicio de sesion de Google
  Future<auth.UserCredential> signInGoogle() => _auth_repo.signInWithGoogle();
  //Caso de uso: Cerrar sesion de Google
  void signOut() => _auth_repo.signOut();
  //Caso de uso: Inicio de sesión con email y password
  Future<auth.UserCredential> signInWithEmailAndPassword(
          String email, String password, BuildContext context) =>
      _auth_repo.signInWithEmailAndPassword(email, password, context);

  auth.User getCurrentUser() => _auth_repo.getCurrentUser();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
