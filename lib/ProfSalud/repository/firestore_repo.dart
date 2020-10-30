

import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:PsyBrain/ProfSalud/repository/firestore_api.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:translator/translator.dart';

class FireStoreRepo{
  
  FireStoreApi fireStoreApi = FireStoreApi();

  FireStoreRepo();

  GoogleTranslator translator = GoogleTranslator();

  Future<String> crearProfSalud(ProfSalud profSalud) async {
    
    try{
    User user = await fireStoreApi.crearProfSalud(profSalud.correo,profSalud.contrasena);

    fireStoreApi.guardarInformacion(profSalud,user.uid);


    return 'Registro Exitoso';
    }catch(e){
      print(e.code);
      var traslation = await translator.translate(e.code,from: 'en',to: 'es');
      print(traslation);
      return traslation.text;
    }
  }

  Future<Map<String,dynamic>> obtenerInformacionProfSalud(ProfSalud profSalud) async {
    return (await fireStoreApi.obtenerInformacion(profSalud.id)).data();
  }


}