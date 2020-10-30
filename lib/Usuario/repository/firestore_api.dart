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
    return apiFireStore.collection('Usuario').doc(uid).get();
  }








}
