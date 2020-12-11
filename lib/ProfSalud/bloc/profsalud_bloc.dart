import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:PsyBrain/ProfSalud/repository/auth_repo.dart';
import 'package:PsyBrain/ProfSalud/repository/cloud_storage_repo.dart';
import 'package:PsyBrain/ProfSalud/repository/firestore_repo.dart';
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

  ProfSaludBloc({initialState}) : super({initialState});

  Future<String> crearProfSalud() async {
    return await _fireStoreRepo.crearProfSalud(profSalud);
  }

  setProfSaludInfo(Map<String,dynamic> data){
    if(data['Contraseña'] == null){
    profSalud = ProfSalud.fromJson(data);
    }else{
      profSalud = ProfSalud.fromJsonPassword(data);
    }
  }


  Future<DocumentSnapshot> obtenerInformacion(String uid){ 
     
    return _fireStoreRepo.obtenerInformacion(uid);
  }

  Future<Map<String,dynamic>> getUserHealthInfo(String uid) async {
    return (await _fireStoreRepo.obtenerInformacion(uid)).data();
  }

  auth.User get currentUser => _authRepo.getCurrentUser();

  Future<void> guardarInformacion(ProfSalud profSaludUser, String uid ){

     
      return _fireStoreRepo.guardarInformacion(profSaludUser, uid);
  }

  signOut() {
    _authRepo.signOut();
  }

  @override
  Stream mapEventToState(event) {
    throw UnimplementedError();
  }

  Future<bool> profSaludRegistrado(String uid) async {
     return (await  obtenerInformacion(uid)).exists;
  }

  Stream<QuerySnapshot> chats(){
    return _fireStoreRepo.chats(currentUser.uid);
  }

  Future<void> actulizarData(Map<String,dynamic> data){
    return _fireStoreRepo.actulizarData(data,currentUser.uid);
  }

  Stream<QuerySnapshot> getListUsers(String query) {
    return _fireStoreRepo.getListUsers(query);
  } 

  Future<void> iniciarChat(String anotherUserUid,String message){
    return _fireStoreRepo.iniciarChat(anotherUserUid,currentUser.uid,message);
  }


    guardarImagen(){
      return _cloudStorageRepo.guardarImagen();
    }

  seleccionarImagen() {
    return _cloudStorageRepo.seleccionarImagen();
  }

  void cambiarFotoPerfil() async{
    String photoURL = await  guardarImagen();
    actulizarData({
      'ImageURL': photoURL
    });
  }
    Future<List<String>> getChatsPS() =>
      _fireStoreRepo.getChatsPS(currentUser.uid);

  Future<Map<String, dynamic>> sendAnalysis(String text) =>
      _watsonRepo.sendAnalysis(text);

  Future<bool> chatExist(String chatID) {
    return _fireStoreRepo.chatExist(chatID);
  }

  Future<void> calificarProfSalud(String uid,double calificacion) {
    return _fireStoreRepo.calificarProfSalud(uid,calificacion);
  }

  getListHealth(String query) {
    return _fireStoreRepo.getListHealth(query);
  }
  

}





