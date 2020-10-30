


import 'package:PsyBrain/User%20Health/model/prof_salud.dart';
import 'package:PsyBrain/User%20Health/repository/firestore_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfSaludBloc extends Bloc{

  ProfSalud profSalud = ProfSalud();
  FireStoreRepo fireStoreRepo = FireStoreRepo();

  ProfSaludBloc({initialState}) : super({initialState});
  

  Future<void> crearProfSalud(){
    fireStoreRepo.crearProfSalud(profSalud);
  }




  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  
}