 



import 'package:PsyBrain/ProfSalud/repository/cloud_storage_api.dart';

class CloudStorageRepo{


   final _cloudStorageApi = CloudStorageApi();

  guardarImagen(){
    return _cloudStorageApi.guardarImagen();
  }

  seleccionarImagen() async {
    return _cloudStorageApi.seleccionarImagen();
  }



 }