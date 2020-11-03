import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:PsyBrain/ProfSalud/repository/auth_repo.dart';
import 'package:PsyBrain/ProfSalud/repository/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class ProfSaludBloc extends Bloc {
  ProfSalud profSalud = ProfSalud();
  FireStoreRepo _fireStoreRepo = FireStoreRepo();
  AuthRepo _authRepo = AuthRepo();

  ProfSaludBloc({initialState}) : super({initialState});

  Future<String> crearProfSalud() async {
    return await _fireStoreRepo.crearProfSalud(profSalud);
  }

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main

  Future<ProfSalud> obtenerInformacion() async {
    final data = await fireStoreRepo.obtenerInformacionProfSalud(profSalud);
    profSalud = ProfSalud.fromJson(data);

    return profSalud;
  }

  auth.User get currentUser => authRepo.getCurrentUser();

  setProfSaludInfo(Map<String,dynamic> data){
    if(data['Contraseña'] == null){
    profSalud = ProfSalud.fromJson(data);
    }else{
      profSalud = ProfSalud.fromJsonPassword(data);
    }
  }

  signOut(){
    authRepo.signOut();
========================================================================
  Future<DocumentSnapshot> obtenerInformacion(String uid) =>
      _fireStoreRepo.obtenerInformacion(uid);
  auth.User get currentUser => _authRepo.getCurrentUser();

  Future<void> guardarInformacion(ProfSalud profSalud, String uid) =>
      _fireStoreRepo.guardarInformacion(profSalud, uid);

  signOut() {
    _authRepo.signOut();
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> interfaz_home_task12
  }

  @override
  Stream mapEventToState(event) {
    throw UnimplementedError();
  }
}
