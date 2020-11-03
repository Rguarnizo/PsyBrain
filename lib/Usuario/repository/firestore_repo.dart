import 'package:PsyBrain/Usuario/model/usuario.dart';
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main
import 'package:PsyBrain/Usuario/repository/firestore_api.dart';
========================================================================
import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12

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
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main
    }catch(e){      
========================================================================
    } catch (e) {
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12
      print(e.code);
      var traslation = await translator.translate(e.code, from: 'en', to: 'es');
      print(traslation);
      return traslation.text;
    }
  }

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main

  Future<Map<String,dynamic>> obtenerInformacionUsuario(Usuario usuario) async {
    return (await fireStoreApi.obtenerInformacion(usuario.id)).data();
  }

  Future <String> actualizarInformacionUsuario(Usuario usuario) async{

    try{
      await fireStoreApi.actualizarInformacionUsuario(usuario);
      return 'Datos Actualizados';
    }catch(e){
      print(e);
      return e;
    }

========================================================================
/*
  Future<Map<String, dynamic>> obtenerInformacionUsuario(
      Usuario usuario) async {
    return (await _fireStoreApi.obtenerInformacion(usuario.id)).data();
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12
  }
*/

  Future<DocumentSnapshot> obtenerInformacion(String uid) =>
      _fireStoreApi.obtenerInformacion(uid);

  Future<void> guardarInformacion(Usuario usuario, String uid) =>
      _fireStoreApi.guardarInformacion(usuario, uid);

  Future<Map<String, dynamic>> getUserInfo(String uid) =>
      _fireStoreApi.getUserInfo(uid);
}
