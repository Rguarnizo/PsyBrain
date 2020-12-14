import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CloudStorageApi{

  final _cloudStorageApi = FirebaseStorage.instance.ref();

  /// Accede al dispositivo y guarda la imagen en FireBase CloudStorage, retorna el link de descarga.
  guardarImagen()async {
    File file = File.fromUri(Uri.file(await seleccionarImagen()));
    String fileName = file.path.split('/').last;

    return  (await (await _cloudStorageApi.child('ChatImages/$fileName').putFile(file).onComplete).ref.getDownloadURL());
  }

   /// Accede al dispositivo y retorna la carpeta en donde se encuentra la imagen.
  seleccionarImagen() async {
    var picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    return picture.path;
  }


}