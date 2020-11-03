import 'package:PsyBrain/Usuario/model/usuario.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreApi {
  final _apiFireStore = FirebaseFirestore.instance;
  final _apiFireAuth = FirebaseAuth.instance;
  final String USUARIO = 'Usuario';

  Future<User> crearUsuario(String email, String contrasena) async {
    UserCredential userRef = await _apiFireAuth.createUserWithEmailAndPassword(
        email: email, password: contrasena);
    return userRef.user;
  }

  Future<void> guardarInformacion(Usuario usuario, String uid) {
    return _apiFireStore.collection(USUARIO).doc(uid).set(usuario.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid) {
    return _apiFireStore.collection(USUARIO).doc(uid).get();
  }

  
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main

  Future<DocumentSnapshot> obtenerInformacion(String uid){

    return apiFireStore.collection('Usuario').doc(apiFireAuth.currentUser.uid).get();
========================================================================
  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    var info = await this.obtenerInformacion(uid);
    return info.data();
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12
    return apiFireStore.collection('Usuario').doc(apiFireAuth.currentUser.uid).get();
  }

  Future<void> actualizarInformacionUsuario(Usuario usuario) {
    User user =apiFireAuth.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('Usuario');
    return users
        .doc(user.uid)
        .update(usuario.json())
        .then((value) => print("Usuario actualizado"))
        .catchError((error) => print("Error al actualizar: $error"));
  }

}
