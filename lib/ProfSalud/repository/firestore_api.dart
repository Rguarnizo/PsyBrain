





import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreApi{


  final apiFireStore = FirebaseFirestore.instance;
  final apiFireAuth = FirebaseAuth.instance;

  Future<User> crearProfSalud(String email, String contrasena) async {
    
  
    UserCredential userRef = await apiFireAuth.createUserWithEmailAndPassword(email: email, password: contrasena);

    return userRef.user;
  }


  Future<void> guardarInformacion(ProfSalud profSalud,String uid){
      return apiFireStore.collection('ProfesionalSalud').doc(uid).set(profSalud.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid){
    return apiFireStore.collection('ProfesionalSalud').doc(uid).get();
  }








}