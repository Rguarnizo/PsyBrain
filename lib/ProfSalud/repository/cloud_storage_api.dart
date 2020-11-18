import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CloudStorageApi{

  final _cloudStorageApi = FirebaseStorage.instance.ref();


  guardarImagen()async {
    File file = File.fromUri(Uri.file(await seleccionarImagen()));
    String fileName = file.path.split('/').last;

    return  (await (await _cloudStorageApi.child('ChatImages/$fileName').putFile(file).onComplete).ref.getDownloadURL());
  }

  seleccionarImagen() async {
    var picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    return picture.path;
  }


}