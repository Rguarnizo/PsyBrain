import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:PsyBrain/ProfSalud/repository/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

class FireStoreRepo {
  FireStoreApi _fireStoreApi = FireStoreApi();

  FireStoreRepo();

  GoogleTranslator translator = GoogleTranslator();

  /// Crea un usuario Utilizando la API de FireStore.
  Future<String> crearProfSalud(ProfSalud profSalud) async {
    try {
      User user = await _fireStoreApi.crearProfSalud(
          profSalud.correo, profSalud.contrasena);

      await _fireStoreApi.guardarInformacion(profSalud, user.uid);

      return 'Registro Exitoso';
    } catch (e) {
      // print(e.code);
      var traslation = await translator.translate(e.code, from: 'en', to: 'es');
      // print(traslation);
      return traslation.text;
    }
  }

  /// Obtiene la información de un usuario con el uid especificado.
  Future<DocumentSnapshot> obtenerInformacion(String uid) =>
      _fireStoreApi.obtenerInformacion(uid);

  /// Guarda información de una instancia de profesional de la salud con el uid especificado.
  Future<void> guardarInformacion(ProfSalud profSalud, String uid) =>
      _fireStoreApi.guardarInformacion(profSalud, uid);

  ///Retorna el Stream de datos de los chats que ha tenido un Usuario con el Uid especificado, de manera
  ///desendente segun la fecha de ultima recepción del mensaje.
  Stream<QuerySnapshot> chats(String uid) {
    return _fireStoreApi.getChats(uid);
  }

  /// Actualiza la información de un usuario con el Json especificado al usuario con el uid especificado,
  Future<void> actulizarData(Map<String, dynamic> data, String uid) {
    return _fireStoreApi.actulizarData(data, uid);
  }

  /// Obtiene la lista de usuarios con lo que su nombre comience por la query.
  Stream<QuerySnapshot> getListUsers(String query) {
    return _fireStoreApi.getListUsers(query);
  }

  /// Inicia un chat entre los usuarios de id's especificados y el mensaje a mandar.
  Future<void> iniciarChat(
      String anotherUserUid, String uid, String message) async {
    _fireStoreApi.iniciarChat(anotherUserUid, uid, message);
  }

  /// Obtiene toda la información de los chats que ccorrespondan al id del usuario especificado.
  Future<List<String>> getChatsPS(String currentUserID) =>
      _fireStoreApi.getChatsPS(currentUserID);

  /// Revisa si el chat con el id especificado existe, retorne true si lo encuentra, false de manera contraria.
  Future<bool> chatExist(String chatID) {
    return _fireStoreApi.chatExist(chatID);
  }

  /// Guarda la información de calificación a un usuario Profesional de la salud con el uid especificado y con la calificación
  /// especificada, esta se añadirá a un array de calificaciones.
  Future<void> calificarProfSalud(String uid,double calificacion) {
    return _fireStoreApi.calificarProfSalud(uid,calificacion);
  }
  /// Retorna la lista de usuarios Profesionales de la salud con los cuales su nombre inicie con la query respectiva.
  getListHealth(String query) {
    return _fireStoreApi.getListHealts(query);
  }
}
