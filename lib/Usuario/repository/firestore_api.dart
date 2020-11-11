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
    usuario.id = uid;
    return _apiFireStore.collection(USUARIO).doc(uid).set(usuario.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid) {
    return _apiFireStore.collection(USUARIO).doc(uid).get();
  }

  
  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    var info = await this.obtenerInformacion(uid);
    return info.data();
  }

  Future<void> actualizarInformacionUsuario(Usuario usuario) {
    User user = _apiFireAuth.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('Usuario');
    return users
        .doc(user.uid)
        .update(usuario.json())
        .then((value) => print("Usuario actualizado"))
        .catchError((error) => print("Error al actualizar: $error"));
  }

  Future<String> eliminarInformacionUsuario() async {
        User user = _apiFireAuth.currentUser;
        try {
           await user.delete();
           print('Usuario eliminado');
        } catch  (e) {
          if (e.code == 'requires-recent-login') {
          print('The user must reauthenticate before this operation can be executed.');
          }
        }
        try{
          CollectionReference users = _apiFireStore.collection('Usuario');
          users.doc(user.uid).delete();
        }
        catch(e){
          print('El usuario no pudo ser eliminado'+ e.toString());
        }
  }

  guardarEncuesta(Map<String, dynamic> jsonPoll,String uid) {
    _apiFireStore.collection(USUARIO).doc(uid).collection('Encuesta').add(jsonPoll);
  }


}
