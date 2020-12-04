
import 'package:PsyBrain/Usuario/repository/cloud_storage_repo.dart';
import 'package:PsyBrain/Usuario/repository/notifications_repo.dart';
import 'package:PsyBrain/Usuario/repository/watson_repo.dart';

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
  final _cloudStorageRepo = CloudStorageRepo();
  final _watson_repo = WatsonRepo();
  final _notificationsRepo = NotificationsRepo();

  Stream<auth.User> userStream = auth.FirebaseAuth.instance.authStateChanges();
  Stream<auth.User> get authStatus => userStream;

  get reciveMessage => _notificationsRepo.reciveMessage;

  Stream<auth.User> authStateChanges() => _auth_repo.authStateChanges();

  auth.User getCurrentUser() => _auth_repo.getCurrentUser();

  UsuarioBloc({initialState}) : super({initialState});

  //Caso de uso: Inicio de sesion de Google
  Future<auth.UserCredential> signInGoogle() => _auth_repo.signInWithGoogle();
  //Caso de uso: Cerrar sesion de Google
  void signOut() => _auth_repo.signOut();
  //Caso de uso: Inicio de sesión con email y password
  Future<auth.UserCredential> signInWithEmailAndPassword(
          String email, String password, BuildContext context) =>
      _auth_repo.signInWithEmailAndPassword(email, password, context);

  //Verificar si el usuario logueado con Google esta registrado en Firebase
  Future<DocumentSnapshot> obtenerInformacion(String uid) =>
      _firestore_repo.obtenerInformacion(uid);

  //Obtener datos del usuario

  Future<Map<String, dynamic>> getUserInfo(String uid) =>
      _firestore_repo.getUserInfo(uid);
  /////////////////////////////////////////////////////////////////////////////////

  //Guardar datos del registro con Google
  Future<void> guardarInformacion(Usuario usuario, String uid) =>
      _firestore_repo.guardarInformacion(usuario, uid);

  Usuario usuario = Usuario();

  Future<void> actualizarData(Map<String,dynamic> data)async{
    return await _firestore_repo.actualizarData(data,currentUser.uid);
  }

  Future<String> crearUsuario() async {
    return await _firestore_repo.crearUsuario(usuario);
  }

  //Caso de uso: Modificar información de usuario
  Future<String> actualizarInformacionUsuario() async {
    String mensaje =
        await _firestore_repo.actualizarInformacionUsuario(usuario);
    return mensaje;
  }

  //Obtener un session ID para la conversación (Watson)
  Future<Map<String, dynamic>> getSessionID() => _watson_repo.getSessionID();

  //Enviar un mensaje a Watson
  Future<Map<String, dynamic>> sendMessage(String text, String sessionID) =>
      _watson_repo.sendMessage(text, sessionID);

  // Servicio de analisis de texto con Functions
  Future<Map<String, dynamic>> sendAnalysis(String text) =>
      _watson_repo.sendAnalysis(text);

  auth.User get currentUser => _auth_repo.getCurrentUser();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  void setUsuarioInfo(Map<String, dynamic> data) {
    if (data['Contraseña'] == null) {
      usuario = Usuario.fromJson(data);
    } else {
      //TODO: Corrección en la forma de trabajar
      usuario = Usuario.fromJsonPassword(data);
    }
  }

  Future<bool> usuarioRegistrado(String uid) async {
    return (await obtenerInformacion(uid)).exists;
  }

  Future<void> guardarEncuesta(Map<String, dynamic> jsonPoll) {
    return _firestore_repo.guardarEncuesta(jsonPoll,currentUser.uid);
  }

  Future<void> escribirChat(String chatUID,String message,String deviceToken){
    return _firestore_repo.escribirChat(chatUID,currentUser.uid,message,deviceToken);
  }

  Future<Stream<QuerySnapshot>> iniciarChat(String anotherUserUid,String message){
    return _firestore_repo.iniciarChat(anotherUserUid,currentUser.uid,message);
  }

  Stream<QuerySnapshot> chat(String chatUid) {
    if(chatUid == null){
      return null;
    }
    return _firestore_repo.chat(chatUid);
  }

  Stream<QuerySnapshot> chats(){
    return _firestore_repo.chats(currentUser.uid);
  }

     guardarImagen(){
      return _cloudStorageRepo.guardarImagen();
    }

  seleccionarImagen() {
    return _cloudStorageRepo.seleccionarImagen();
  }

  void cambiarFotoPerfil() async{
    String photoURL = await  guardarImagen();
    actualizarData({
      'ImageURL': photoURL
    });

  }

  Future<void> escribirChatImagen(chatUID, url) {
    return _firestore_repo.escribirChatImagen(chatUID,url,currentUser.uid);
  }

  Future<bool> chatExist(String chatID) {
    return _firestore_repo.chatExist(chatID);
  }

  permitirNotificaciones(){
    _notificationsRepo.permitirNotificaciones(currentUser.uid);
  }

  
}
