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
  String _licencia;
  
  

  ProfesionalSalud({id,nombres,apellidos,fechaNacimiento,telefono,cedula,password,licencia}){
    _id = id;
    _nombres = nombres;
    _apellidos = apellidos;
    _fechaNacimiento = fechaNacimiento;
    _telefono = telefono;
    _cedula = cedula;
    _password = password;
    _licencia = licencia;
  }

  //? Datos provenientes de un Mapa('Diccionario').
  ProfesionalSalud.map(dynamic obj){
    this._nombres = obj['nombres'];
    this._apellidos = obj['apellidos'];
    this._fechaNacimiento = obj['fechaNacimiento'];
    this._telefono = obj['telefono'];
    this._cedula = obj['cedula'];
    this._licencia = obj['licencia'];
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
      'Licencia': _licencia,
    };
  }


  Future<dynamic> guardarDatos() async{

    User profSalud; 
    try {
      //! Crea una instancia a la base de datos (FirebaseAuth.instance) y trata de crear un usaurio con el email y la constraseña.
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _id,
      password: _password,
    );

    //! Si se logró crear se inicia sesión con el usuario que se acaba de crear.
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _id, password: _password);

    //! se asigna el usuario a devolver para dirigirlo a la pantalla de Home con los respectivos datos.
    profSalud = FirebaseAuth.instance.currentUser;

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

    //! Ya se creo el usuario pero aun no se ha almacenado la información en la base de datos. Se hace con el siguiente metodo.
    guardarDatosDB(profSalud);
    

  
    return profSalud;
  }

  Future<DocumentSnapshot> guardarDatosDB(User user) async {

    //? Actualiza la foto de perfil por una predeterminada.
    user.updateProfile(photoURL: 'https://www.pinclipart.com/picdir/big/213-2135777_finance-clipart-capital-resource-brain-cartoon-png-transparent.png');

    //! Crea una instancia ahora de la información. Se dirige a la colección Profesional Salud(Si no existe la crea), y se dirige al documento con el uid del usuario (Si no existe lo crea).
    DocumentReference profSaludRef = FirebaseFirestore.instance.collection('Profesional Salud').doc(user.uid);

    //! Almacena la información del profesional de la salud, esto lo hace con un JSON, o un Map(o diccionario).
    profSaludRef.set(jsonData());
    
    
    //* Verificar en la consola de Firebase en la sección de Cloud Firestore, allí aparecen las colecciones y los documentos.
    
    //? Esto siguiente es una prueba no preocuparse por ello.
    DocumentSnapshot profSaludData = await profSaludRef.get();
    return profSaludData;
  }


  Future<Map> obtenerDatosDB(User user) async{ 
    // * TODO: Manejo de excepciones de obtención de datos.

    

    //! Busca en la colección Profesional Salud el documento que tenga el id del usuario. Este tendra toda la información.
    DocumentReference profSaludref = FirebaseFirestore.instance.collection('Profesional Salud').doc(user.uid);


    //! Para obtener la información se hace lo siguiente. Esta información es un DocumentSnapshot, con este no podemos trabajar.
    DocumentSnapshot infoProfSalud = await profSaludref.get();

    //! Para obtener el mapa se hace lo siguiente, ya con el mapa se puede obtener cualquier información con la llave del atributo.
    return infoProfSalud.data();
  }

  actualizarDatosDB(User user, Map<String,dynamic> datos) async{
    // * TODO: Manejo de excepciones actualizando los datos.


    DocumentReference profSaludref = FirebaseFirestore.instance.collection('Profesional Salud').doc(user.uid);
    profSaludref.set(datos);

  }
}