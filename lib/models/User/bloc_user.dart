import 'package:PsyBrain/models/services/auth_service.dart';
import 'package:PsyBrain/models/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class UserBloc extends Bloc {

    @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    
  }

  Map<String,dynamic> userData ={
    'Nombres': '',
    'Apellidos': '',
    'Cedula': '',
    'FechaNacimiento': '',
    'Licencia': ''
  };

  final authService = AuthAPI();
  final dataBaseService = DataBaseApi();
  final String dbPath = 'Users';
  

  Stream<User> streamFirebase =
      FirebaseAuth.instance.authStateChanges();

  UserBloc({initialState}) : super(initialState);
  Stream<User> get authStatus => streamFirebase;

  User get currentUser => FirebaseAuth.instance.currentUser;

  String get userUid => FirebaseAuth.instance.currentUser.uid;

  Future <dynamic> createAccount(String email,String password) async {
      final result = await authService.createAccount(email: email, password: password);
      await setDefaultImage();
      updateInfo();      
      return result;
  }

  //Caso de uso: Inicio de sesion de Google
  Future<User> signInGoogle() async{ 
    await authService.signInGoogle();
    
    if( await getInfo() == null){
      userData = {
      'DisplayName': currentUser.displayName,      
      'Email' : currentUser.email,
      'Telefono': '',
      'Cedula' : '',
      'FechaNacimiento': '',
      
      };
    updateInfo();      
    }    
    return currentUser;
  }


  //Caso de uso: Inicio de sesión con email y password
  Future<User> signInWithEmailAndPassword(String email, String password) {
    return authService.signInWithEmailAndPassword(email, password);
  }

  Future<Map<String,dynamic>> getInfo() async{
    DocumentSnapshot dsUser = await dataBaseService.getDocumentInfo(collection: dbPath, document: userUid);
    
    userData = dsUser.data();
    
    
    return userData;
  }

  Future updateInfo() async{
    return await dataBaseService.updateInfo(collection: dbPath, document: userUid, data: userData);
  }

  Future<void> setDefaultImage(){
      return currentUser.updateProfile(photoURL:'https://www.pinclipart.com/picdir/big/213-2135777_finance-clipart-capital-resource-brain-cartoon-png-transparent.png');
  }


  signOut() {
    authService.signOut();
  }

}
