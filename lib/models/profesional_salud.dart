import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ProfesionalSalud {

  String _id;
  String _password;
  String _nombres;
  String _apellidos;
  String _fechaNacimiento;
  String _telefono;
  String _cedula;
  
  

  ProfesionalSalud({id,nombres,apellidos,fechaNacimiento,telefono,cedula,password}){
    _id = id;
    _nombres = nombres;
    _apellidos = apellidos;
    _fechaNacimiento = fechaNacimiento;
    _telefono = telefono;
    _cedula = cedula;
    _password = password;
  }

  //? Datos provenientes de un Mapa('Diccionario').
  ProfesionalSalud.map(dynamic obj){
    this._nombres = obj['nombres'];
    this._apellidos = obj['apellidos'];
    this._fechaNacimiento = obj['fechaNacimiento'];
    this._telefono = obj['telefono'];
    this._cedula = obj['cedula'];
  }

  //? Getters
  String get id => _id;
  String get nombres => _nombres;
  String get apellidos => _apellidos;
  String get fechaNacimiento => _fechaNacimiento;
  String get telefono => _telefono;
  String get cedula => _cedula;


  Map<String,dynamic> jsonData(){
    return {
      'id': _id,
      'Nombres': _nombres,
      'Apellidos' : _apellidos,
      'Cedula': _cedula,
      'Fecha Nacimiento': _fechaNacimiento,
      'Telefono': _telefono,
    };
  }


  Future<dynamic> guardarDatos() async{

    User profSalud; 
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _id,
      password: _password,
    );
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _id, password: _password);
    profSalud = FirebaseAuth.instance.currentUser;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 'Fallo en inicio de sesión';
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 'Fallo en inicio de sesión';
    }
  } catch (e) {
    print(e); 
    return 'Fallo en inicio de sesión';
  }
  
    guardarDatosDB(profSalud);

  
    return profSalud;
  }

  Future<DocumentSnapshot> guardarDatosDB(User user) async {

    DocumentReference profSaludRef = FirebaseFirestore.instance.collection('Profesional Salud').doc(user.uid);
 
    profSaludRef.set(jsonData());

    DocumentSnapshot profSaludData = await profSaludRef.get();

    return profSaludData;
  }


}