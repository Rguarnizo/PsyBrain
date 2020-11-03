
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:PsyBrain/Usuario/model/usuario.dart';
import 'package:PsyBrain/Usuario/repository/auth_repo.dart';
import 'package:PsyBrain/Usuario/repository/firestore_repo.dart';


class UsuarioBloc extends Bloc {
  final _auth_repo = AuthRepo();

  Stream<auth.User> userStream = auth.FirebaseAuth.instance.authStateChanges();
  Stream<auth.User> get authStatus  => userStream;

  UsuarioBloc({initialState}) : super({initialState});

  //Caso de uso: Inicio de sesion de Google
  Future<auth.UserCredential> signInGoogle() => _auth_repo.signInWithGoogle();
  //Caso de uso: Cerrar sesion de Google
  void signOut() => _auth_repo.signOut();
  //Caso de uso: Inicio de sesión con email y password
  Future<auth.UserCredential> signInWithEmailAndPassword(
          String email, String password, BuildContext context) =>
      _auth_repo.signInWithEmailAndPassword(email, password, context);

  auth.User getCurrentUser() => _auth_repo.getCurrentUser();

  //////////////////////////////////////////////////////////////////////////////////

   Usuario usuario = Usuario();
   FireStoreRepo fireStoreRepo = FireStoreRepo();
  //Caso de uso: Registrar usuario
  Future<String> crearUsuario() async{
    return await fireStoreRepo.crearUsuario(usuario);
  }
  //Caso de uso: consultar información de usuario
  Future<Usuario> obtenerInformacion() async {
    final data = await fireStoreRepo.obtenerInformacionUsuario(usuario);
    usuario = Usuario.fromJson(data);
    return usuario;
  }
  //Caso de uso: Modificar información de usuario
  Future<String> actualizarInformacionUsuario() async{

    String mensaje = await fireStoreRepo.actualizarInformacionUsuario(usuario);
    return mensaje;

  }




  auth.User get currentUser => _auth_repo.getCurrentUser();


  @override
  void dispose() {
    
  }

  @override
  Stream mapEventToState(event) {
    throw UnimplementedError();
  }

  void setUsuarioInfo(Map<String,dynamic> data) {
    if(data['Contraseña'] == null){
      usuario = Usuario.fromJson(data);
    }else{
      usuario = Usuario.fromJsonPassword(data);
    }
  }
}
