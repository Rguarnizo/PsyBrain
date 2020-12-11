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

  Future<DocumentSnapshot> obtenerInformacion(String uid) =>
      _fireStoreApi.obtenerInformacion(uid);

  Future<void> guardarInformacion(ProfSalud profSalud, String uid) =>
      _fireStoreApi.guardarInformacion(profSalud, uid);

  Stream<QuerySnapshot> chats(String uid) {
    return _fireStoreApi.getChats(uid);
  }

  Future<void> actulizarData(Map<String, dynamic> data, String uid) {
    return _fireStoreApi.actulizarData(data, uid);
  }

  Stream<QuerySnapshot> getListUsers(String query) {
    return _fireStoreApi.getListUsers(query);
  }

  Future<void> iniciarChat(
      String anotherUserUid, String uid, String message) async {
    _fireStoreApi.iniciarChat(anotherUserUid, uid, message);
  }

  Future<List<String>> getChatsPS(String currentUserID) =>
      _fireStoreApi.getChatsPS(currentUserID);

  Future<bool> chatExist(String chatID) {
    return _fireStoreApi.chatExist(chatID);
  }

  Future<void> calificarProfSalud(String uid,double calificacion) {
    return _fireStoreApi.calificarProfSalud(uid,calificacion);
  }

  getListHealth(String query) {
    return _fireStoreApi.getListHealts(query);
  }
}
