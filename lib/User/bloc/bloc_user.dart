import 'package:PsyBrain/User/repository/auth_repo.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
  final _auth_repo = AuthRepo();

  Stream<User> streamFirebase =
      FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  User get currentUser => FirebaseAuth.instance.currentUser;

  //Caso de uso: Inicio de sesion de Google
  Future<User> signInGoogle() { 
    return _auth_repo.signInGoogle();
  }

  //Caso de uso: Cerrar sesion de Google
  void signOutGoogle() {
    return _auth_repo.signOutGoogle();
  }

  //Caso de uso: Inicio de sesión con email y password
  Future<User> signInWithEmailAndPassword(String email, String password, BuildContext context) {
    return _auth_repo.signInWithEmailAndPassword(email, password, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
