import 'package:PsyBrain/Usuario/model/usuario.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:translator/translator.dart';

import 'firestore_api.dart';

class FireStoreRepo{

  FireStoreApi fireStoreApi = FireStoreApi();

  FireStoreRepo();

  GoogleTranslator translator = GoogleTranslator();

  Future<String> crearUsuario(Usuario usuario) async {

    try{
      User user = await fireStoreApi.crearUsuario(usuario.correo,usuario.contrasena);

      fireStoreApi.guardarInformacion(usuario,user.uid);


      return 'Registro Exitoso';
    }catch(e){
      print(e.code);
      var traslation = await translator.translate(e.code,from: 'en',to: 'es');
      print(traslation);
      return traslation.text;
    }
  }

  Future<Map<String,dynamic>> obtenerInformacionUsuario(Usuario usuario) async {
    return (await fireStoreApi.obtenerInformacion(usuario.id)).data();
  }


}