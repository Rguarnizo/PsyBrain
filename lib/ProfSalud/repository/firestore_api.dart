





import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreApi{


  final _apiFireStore = FirebaseFirestore.instance;
  final _apiFireAuth = FirebaseAuth.instance;
  final String PROFESIONALSALUD = 'ProfesionalSalud';

  Future<User> crearProfSalud(String email, String contrasena) async {
    
  
    UserCredential userRef = await _apiFireAuth.createUserWithEmailAndPassword(email: email, password: contrasena);

    return userRef.user;
  }


  Future<void> guardarInformacion(ProfSalud profSalud,String uid){
      return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).set(profSalud.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid){
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).get();
  }








}