import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Usuario {


  String _id;
  String _password;
  String _nombres;
  String _apellidos;
  String _fechaNacimiento;
  String _telefono;



  Usuario({id,nombres,apellidos,fechaNacimiento,telefono,cedula,password,licencia}){
    _id = id;
    _nombres = nombres;
    _apellidos = apellidos;
    _fechaNacimiento = fechaNacimiento;
    _telefono = telefono;
    _password = password;
  }

  Usuario.map(dynamic obj){
    this._nombres = obj['nombres'];
    this._apellidos = obj['apellidos'];
    this._fechaNacimiento = obj['fechaNacimiento'];
    this._telefono = obj['telefono'];
  }

  //? Getters
  String get id => _id;
  String get nombres => _nombres;
  String get apellidos => _apellidos;
  String get fechaNacimiento => _fechaNacimiento;
  String get telefono => _telefono;

  Map<String,dynamic> jsonData(){
    return {
      'id': _id,
      'Nombres': _nombres,
      'Apellidos' : _apellidos,
      'Fecha Nacimiento': _fechaNacimiento,
      'Telefono': _telefono,
    };
  }

  Future<dynamic> guardarDatos() async {
    User usuario;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _id,
        password: _password,
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _id, password: _password);

      usuario = FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      //? ERRORES POSIBLES
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'La contraseña es muy corta';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'El email ya esta registrado';
      }
    } catch (e) {
      print(e);
      return 'Fallo en inicio de sesión';
    }

    guardarDatosDB(usuario);
    return usuario;
  }


    Future<DocumentSnapshot> guardarDatosDB(User user) async {

      user.updateProfile(photoURL: 'https://www.pinclipart.com/picdir/big/213-2135777_finance-clipart-capital-resource-brain-cartoon-png-transparent.png');

      DocumentReference usuarioref = FirebaseFirestore.instance.collection('Profesional Salud').doc(user.uid);

      usuarioref.set(jsonData());

    }
    Future<DocumentSnapshot> obtenerDatosDB() async{


    }
}


