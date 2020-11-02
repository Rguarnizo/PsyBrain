import 'package:PsyBrain/Usuario/model/usuario.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreApi{


  final apiFireStore = FirebaseFirestore.instance;
  final apiFireAuth = FirebaseAuth.instance;

  Future<User> crearUsuario(String email, String contrasena) async {


    UserCredential userRef = await apiFireAuth.createUserWithEmailAndPassword(email: email, password: contrasena);
    return userRef.user;
  }


  Future<void> guardarInformacion(Usuario usuario,String uid){
    return apiFireStore.collection('Usuario').doc(uid).set(usuario.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid){

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
