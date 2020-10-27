import 'package:PsyBrain/models/User/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_service.dart';



class UserBloc extends Bloc {

    @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    
  }

  Map<String,dynamic> userData;

  final authService = AuthAPI();
  final dataBaseService = DataBaseApi();
  final String dbPath = 'Users';
  

  Stream<User> streamFirebase =
      FirebaseAuth.instance.authStateChanges();

  UserBloc({initialState}) : super(initialState);
  Stream<User> get authStatus => streamFirebase;

  User get currentUser => FirebaseAuth.instance.currentUser;

  String get userUid => FirebaseAuth.instance.currentUser.uid;
  //Caso de uso: Inicio de sesion de Google
  Future<User> signInGoogle() { 
    return authService.signInGoogle();
  }


  //Caso de uso: Inicio de sesión con email y password
  Future<User> signInWithEmailAndPassword(String email, String password, BuildContext context) {
    return authService.signInWithEmailAndPassword(email, password, context);
  }

  Future<void> getInfo() async{
    DocumentSnapshot dsUser = await dataBaseService.getDocumentInfo(collection: dbPath, document: userUid);
    
    userData = dsUser.data();
    
    
    return;
  }

  Future updateInfo() async{
    return await dataBaseService.updateInfo(collection: dbPath, document: userUid, data: userData);
  }


  void signOut() {
    authService.signOut();
  }

}
