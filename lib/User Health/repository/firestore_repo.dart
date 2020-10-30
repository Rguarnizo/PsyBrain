

import 'package:PsyBrain/User%20Health/model/prof_salud.dart';
import 'package:PsyBrain/User%20Health/repository/firestore_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreRepo{
  
  FireStoreApi fireStoreApi = FireStoreApi();

  FireStoreRepo();

  Future<bool> crearProfSalud(ProfSalud profSalud) async {
    
    try{
    User user = await fireStoreApi.crearProfSalud(profSalud.correo,profSalud.contrasena);

    fireStoreApi.guardarInformacion(profSalud,user.uid);


    return true;
    }catch(e){
      print(e.toString());
      return false;
    }
    

  }


}