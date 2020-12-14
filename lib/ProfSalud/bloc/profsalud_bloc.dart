import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:PsyBrain/ProfSalud/repository/auth_repo.dart';
import 'package:PsyBrain/ProfSalud/repository/cloud_storage_repo.dart';
import 'package:PsyBrain/ProfSalud/repository/firestore_repo.dart';
import 'package:PsyBrain/Usuario/repository/notifications_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:PsyBrain/ProfSalud/repository/watson_repo.dart';

class ProfSaludBloc extends Bloc {
  ProfSalud profSalud = ProfSalud();
  FireStoreRepo _fireStoreRepo = FireStoreRepo();
  AuthRepo _authRepo = AuthRepo();
  CloudStorageRepo _cloudStorageRepo = CloudStorageRepo();
  WatsonRepo _watsonRepo = WatsonRepo();
  NotificationsRepo _notificationsRepo = NotificationsRepo();

  ProfSaludBloc({initialState}) : super({initialState});

  /// Crea un usuario respecto a la información previamente guardada, esta se puede setear con la función setProfSaludInfo()
  Future<String> crearProfSalud() async {
    return await _fireStoreRepo.crearProfSalud(profSalud);
  }


  /// Recibe un Mapa de tipo string dynamic con la información del Usuario Profesional de la salud
  /// Este debe contener como llaves los campos de Nombres,Apellidos,Cedula,Correo,FechaNacimiento
  /// Licencia, Telefono y UID principalmente, se pueden incluir otros campos si así se ve conveniente.
  setProfSaludInfo(Map<String,dynamic> data){
    if(data['Contraseña'] == null){
    profSalud = ProfSalud.fromJson(data);
    }else{
      profSalud = ProfSalud.fromJsonPassword(data);
    }
  }

  /// Retorna la información de un Profesional de la salud, recibe el uid del Profesional y retorna un Document Snapshot
  /// Para acceder a los datos realice .data(), lo cual devolverá un Mapa String dynamic.
  Future<DocumentSnapshot> obtenerInformacion(String uid){ 
     
    return _fireStoreRepo.obtenerInformacion(uid);
  }

  /// Retorna la información de un Profesional de la salud, recibe el uid del Profesional y retorna el Mapa String dynamic con la información.
  Future<Map<String,dynamic>> getUserHealthInfo(String uid) async {
    return (await _fireStoreRepo.obtenerInformacion(uid)).data();
  }

  /// Retorna el usuario actualmente loggeado en la aplicación. Acceda a los atributo de este usuario para ver más información sobre este.
  auth.User get currentUser => _authRepo.getCurrentUser();


  /// Guarda la información de una instancia de un Profesional de la salud, este metodo es solo valido Para Administradores.
  Future<void> guardarInformacion(ProfSalud profSaludUser, String uid ){     
      return _fireStoreRepo.guardarInformacion(profSaludUser, uid);
  }

  /// Cierra todas las sesiones del usuario actual, tanto si se logeó con Google como si lo hizo de manera Usual.
  signOut() {
    _authRepo.signOut();
  }

  @override
  Stream mapEventToState(event) {
    throw UnimplementedError();
  }

 /// Retorna verdadero si existe el Profesional de la salud, de lo contrario retorna Falso.
  Future<bool> profSaludRegistrado(String uid) async {
     return (await  obtenerInformacion(uid)).exists;
  }

  /// Retorna los chats en los cuales el usuario actual ha tenido conversaciones. 
  Stream<QuerySnapshot> chats(){
    return _fireStoreRepo.chats(currentUser.uid);
  }

  /// Actualiza los datos deñ Profesional de la salud actualmente loggeado, utilice este metodo para añadir más atributos
  /// si así lo desea.
  Future<void> actulizarData(Map<String,dynamic> data){
    return _fireStoreRepo.actulizarData(data,currentUser.uid);
  }

  /// Obtiene toda la lista de Profesionales de la salud registrados segun el inicio de la Query.
  Stream<QuerySnapshot> getListUsers(String query) {
    return _fireStoreRepo.getListUsers(query);
  } 

  /// Inicia el chat con el usuario mandado por el id, y el Profesional de la salud loggeado en ese momento. Manda el mensaje
  /// mandado por el segundo parametro.
  Future<void> iniciarChat(String anotherUserUid,String message){
    return _fireStoreRepo.iniciarChat(anotherUserUid,currentUser.uid,message);
  }

  /// Axede a los archivos del dispositivo para seleccionar una imagen luego de esto si todo sale bien retorna el link de
  /// descarga correspondiente al archivo seleccionado y guardado en la nube.
  guardarImagen(){
      return _cloudStorageRepo.guardarImagen();
  }

  /// Accede a los archivos del dispositivo y unicamente guarda la imagen en la nube. NOTA: No retorna link de descarga
  /// Para ello utilizar la función guardarImagen();
  seleccionarImagen() {
    return _cloudStorageRepo.seleccionarImagen();
  }

  ///Accede a los archivos del dispositivo y guarda la imagen seleccionada en la nube, actualiza la información del usuario
  ///con el correspondiente link de descarga de la imagen.
  void cambiarFotoPerfil() async{
    String photoURL = await  guardarImagen();
    actulizarData({
      'ImageURL': photoURL
    });
  }

  /// Obtiene todos los chats que el Profesional de la salud Loggeado en ese momento tenga, retorna una lista completa de
  /// todas las conversaciones que halla tenido en ese momento.
    Future<List<String>> getChatsPS() =>
      _fireStoreRepo.getChatsPS(currentUser.uid);

  /// Accede a la Api de analisis de texto de IBM y retorna el resultado del analisis.
  Future<Map<String, dynamic>> sendAnalysis(String text) =>
      _watsonRepo.sendAnalysis(text);

  /// Retorna true si el chat con el correspondiente ID existe de lo contrario retorna false
  Future<bool> chatExist(String chatID) {
    return _fireStoreRepo.chatExist(chatID);
  }

  /// Guarda en la base de datos la calificación hacia el profesional de la salud descrito en Uid con la calificación descrita.
  Future<void> calificarProfSalud(String uid,double calificacion) {
    return _fireStoreRepo.calificarProfSalud(uid,calificacion);
  }

  /// Retorna los Usuarios Profesionales de la salud que comiencen con el nombre tal como la query.
  getListHealth(String query) {
    return _fireStoreRepo.getListHealth(query);
  }

  /// Accede a la configuración del dispositivo para permitir el uso de notificaciones.
  permitirNotificaciones() {
    return _notificationsRepo.permitirNotificaciones(currentUser.uid);
  }
  

}





