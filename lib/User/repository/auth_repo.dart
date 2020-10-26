import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'auth_api.dart';

class AuthRepo {
  final _authAPI = AuthAPI();

  Future<User> signInGoogle() => _authAPI.signInGoogle();
  
  signOutGoogle() => _authAPI.signOutGoogle();
  
  Future<User>signInWithEmailAndPassword(
          String email, String password, BuildContext context) =>
      _authAPI.signInWithEmailAndPassword(email, password, context);
      
}
