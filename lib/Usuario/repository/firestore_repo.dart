import 'package:PsyBrain/Usuario/model/usuario.dart';
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
    } catch (e) {
      print(e.code);
      var traslation = await translator.translate(e.code, from: 'en', to: 'es');
      print(traslation);
      return traslation.text;
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
}
