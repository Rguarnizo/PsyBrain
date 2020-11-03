import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:PsyBrain/Usuario/model/usuario.dart';
import 'package:PsyBrain/Usuario/repository/auth_repo.dart';
import 'package:PsyBrain/Usuario/repository/firestore_repo.dart';

class UsuarioBloc extends Bloc {
  final _auth_repo = AuthRepo();
  final _firestore_repo = FireStoreRepo();

  Stream<auth.User> userStream = auth.FirebaseAuth.instance.authStateChanges();
  Stream<auth.User> get authStatus => userStream;

  Stream<auth.User> authStateChanges() => _auth_repo.authStateChanges();

  UsuarioBloc({initialState}) : super({initialState});

  //Caso de uso: Inicio de sesion de Google
  Future<auth.UserCredential> signInGoogle() => _auth_repo.signInWithGoogle();
  //Caso de uso: Cerrar sesion de Google
  void signOut() => _auth_repo.signOut();
  //Caso de uso: Inicio de sesión con email y password
  Future<auth.UserCredential> signInWithEmailAndPassword(
          String email, String password, BuildContext context) =>
      _auth_repo.signInWithEmailAndPassword(email, password, context);
  auth.User getCurrentUser() => _auth_repo.getCurrentUser();

  //Verificar si el usuario logueado con Google esta registrado en Firebase
  Future<DocumentSnapshot> obtenerInformacion(String uid) =>
      _firestore_repo.obtenerInformacion(uid);

  //Obtener datos del usuario

  Future<Map<String, dynamic>> getUserInfo(String uid) =>
      _firestore_repo.getUserInfo(uid);
  //////////////////////////////////////////////////////////////////////////////////

  //Guardar datos del registro con Google
  Future<void> guardarInformacion(Usuario usuario, String uid) =>
      _firestore_repo.guardarInformacion(usuario, uid);

  Usuario usuario = Usuario();

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main
   FireStoreRepo fireStoreRepo = FireStoreRepo();
  //Caso de uso: Registrar usuario
  Future<String> crearUsuario() async{
    return await fireStoreRepo.crearUsuario(usuario);
========================================================================
  Future<String> crearUsuario() async {
    return await _firestore_repo.crearUsuario(usuario);
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12
  }
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main
  //Caso de uso: consultar información de usuario
  Future<Usuario> obtenerInformacion() async {
========================================================================

  /*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12
  Future<Usuario> obtenerInformacion() async {
    final data = await _firestore_repo.obtenerInformacionUsuario(usuario);
    usuario = Usuario.fromJson(data);
    return usuario;
  }
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main
  //Caso de uso: Modificar información de usuario
  Future<String> actualizarInformacionUsuario() async{

    String mensaje = await fireStoreRepo.actualizarInformacionUsuario(usuario);
    return mensaje;

  }




  auth.User get currentUser => _auth_repo.getCurrentUser();
========================================================================
  */
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  void setUsuarioInfo(Map<String,dynamic> data) {
    if(data['Contraseña'] == null){
      usuario = Usuario.fromJson(data);
    }else{
      usuario = Usuario.fromJsonPassword(data);
    }
  }
}
