




import 'package:PsyBrain/User%20Health/model/prof_salud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreApi{


  final apiFireStore = FirebaseFirestore.instance;
  final apiFireAuth = FirebaseAuth.instance;

  Future<User> crearProfSalud(String email, String contrasena) async {
    
  
    UserCredential userRef = await apiFireAuth.createUserWithEmailAndPassword(email: email, password: contrasena);

    return userRef.user;
  }


  Future<DocumentSnapshot> guardarInformacion(ProfSalud profSalud,String uid){
      apiFireStore.collection('ProfesionalSalud').doc(uid).set(
          {
          'Nombres': profSalud.nombres,
          'Apellidos': profSalud.apellidos,
          'Correo': profSalud.correo,
          'FechaNacimiento': profSalud.fechaNacimiento,
          'Licencia': profSalud.licencia,
          'Cedula': profSalud.cedula,
          'Telefono': profSalud.telefono,
        }
      );
  }








}