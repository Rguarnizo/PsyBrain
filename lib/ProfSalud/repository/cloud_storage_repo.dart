 



import 'package:PsyBrain/ProfSalud/repository/cloud_storage_api.dart';

class CloudStorageRepo{


   final _cloudStorageApi = CloudStorageApi();
  /// Guarda la imagen en la base de datos de FireBase CloudStorage y retorna el link de descarga.
  guardarImagen(){
    return _cloudStorageApi.guardarImagen();
  }
  /// Guarda la imagen en la base de datos de FireBase CloudStorage. NOTA: NO retorna el link de decarga.
  seleccionarImagen() async {
    return _cloudStorageApi.seleccionarImagen();
  }



 }