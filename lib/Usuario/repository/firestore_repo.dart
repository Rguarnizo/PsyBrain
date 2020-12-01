import 'package:PsyBrain/Usuario/model/usuario.dart';
import 'package:PsyBrain/Usuario/repository/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:translator/translator.dart';

import 'firestore_api.dart';

class FireStoreRepo {
  FireStoreApi _fireStoreApi = FireStoreApi();

  FireStoreRepo();

  GoogleTranslator translator = GoogleTranslator();

  Future<String> crearUsuario(Usuario usuario) async {
    try {
      User user =
          await _fireStoreApi.crearUsuario(usuario.correo, usuario.contrasena);

      await _fireStoreApi.guardarInformacion(usuario, user.uid);

      return 'Registro Exitoso';
    } on Exception catch (e) {
      //print(e);
      var traslation =
          await translator.translate(e.toString(), from: 'en', to: 'es');
      //print(traslation);
      return traslation.text;
    }
  }

  Future<Map<String, dynamic>> obtenerInformacionUsuario(
      Usuario usuario) async {
    return (await _fireStoreApi.obtenerInformacion(usuario.id)).data();
  }

  Future<String> actualizarInformacionUsuario(Usuario usuario) async {
    try {
      await _fireStoreApi.actualizarInformacionUsuario(usuario);
      return 'Datos Actualizados';
    } catch (e) {
      // print(e);
      return e;
    }
  }
/*
  Future<Map<String, dynamic>> obtenerInformacionUsuario(
      Usuario usuario) async {
    return (await _fireStoreApi.obtenerInformacion(usuario.id)).data();
  }
*/

  Future<DocumentSnapshot> obtenerInformacion(String uid) =>
      _fireStoreApi.obtenerInformacion(uid);

  Future<void> guardarInformacion(Usuario usuario, String uid) =>
      _fireStoreApi.guardarInformacion(usuario, uid);

  Future<Map<String, dynamic>> getUserInfo(String uid) =>
      _fireStoreApi.getUserInfo(uid);

  Future<String> eliminarInformacionUsuario() async {
    return await _fireStoreApi.eliminarInformacionUsuario();
  }

  Future<void> guardarEncuesta(
      Map<String, dynamic> jsonPoll, String uid) async {
    return await _fireStoreApi.guardarEncuesta(jsonPoll, uid);
  }

  escribirChat(String chatUID, String uid, String message) async {
    await _fireStoreApi.escribirChat(chatUID, uid, message);
  }

  Stream<QuerySnapshot> chat(String chatUid) {
    return _fireStoreApi.chat(chatUid);
  }

  Stream<QuerySnapshot> chats(String uid) {
    return _fireStoreApi.chats(uid);
  }

  Future<void> iniciarChat(
      String anotherUserUid, String uid, String message) async {
    _fireStoreApi.iniciarChat(anotherUserUid, uid, message);
  }

  Future<void> actualizarData(Map<String, dynamic> data, String uid) {
    return _fireStoreApi.actualizarData(data, uid);
  }

  Future<void> escribirChatImagen(chatUID, url, uid) {
    return _fireStoreApi.escribirChatImagen(chatUID, url, uid);
  }
}
