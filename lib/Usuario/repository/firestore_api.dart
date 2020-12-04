import 'package:PsyBrain/Usuario/model/usuario.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notifications_api.dart';

class FireStoreApi {
  final _apiFireStore = FirebaseFirestore.instance;
  final _apiFireAuth = FirebaseAuth.instance;
  final String USUARIO = 'Usuario';

  Future<User> crearUsuario(String email, String contrasena) async {
    UserCredential userRef = await _apiFireAuth.createUserWithEmailAndPassword(
        email: email, password: contrasena);
    return userRef.user;
  }

  Future<void> guardarInformacion(Usuario usuario, String uid) {
    usuario.id = uid;
    usuario.imageURL = _apiFireAuth.currentUser.photoURL ??
        'https://www.pngkit.com/png/full/383-3836644_thinking-brain-png-png.png';
    return _apiFireStore.collection(USUARIO).doc(uid).set(usuario.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid) {
    return _apiFireStore.collection(USUARIO).doc(uid).get();
  }

  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    var info = await this.obtenerInformacion(uid);
    return info.data();
  }

  Future<void> actualizarInformacionUsuario(Usuario usuario) {
    User user = _apiFireAuth.currentUser;
    CollectionReference users =
        FirebaseFirestore.instance.collection('Usuario');
    return users
        .doc(user.uid)
        .update(usuario.json())
        .then((value) => print("Usuario actualizado"))
        .catchError((error) => print("Error al actualizar: $error"));
  }

  Future<String> eliminarInformacionUsuario() async {
    User user = _apiFireAuth.currentUser;
    try {
      await user.delete();
      print('Usuario eliminado');
    } catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
    try {
      CollectionReference users = _apiFireStore.collection('Usuario');
      users.doc(user.uid).delete();
    } catch (e) {
      print('El usuario no pudo ser eliminado' + e.toString());
    }
  }

  guardarEncuesta(Map<String, dynamic> jsonPoll, String uid) {
    _apiFireStore
        .collection(USUARIO)
        .doc(uid)
        .collection('Encuesta')
        .add(jsonPoll);
  }

  Future<Stream<QuerySnapshot>> iniciarChat(String anotherUserUid, String uid, String message) async {
        String chatUid = '$uid-$anotherUserUid';
    await _apiFireStore.collection('Chats').doc(chatUid).set({
      'Uid': [uid, anotherUserUid],
      'LastEditingTime': Timestamp.now(),
    });

    await _apiFireStore
        .collection('Chats')
        .doc('$uid-$anotherUserUid')
        .collection('$uid-$anotherUserUid')
        .doc()
        .set({
      'sendUid': uid,
      'reciveUid': anotherUserUid,
      'Message': message,
      'Timestamp': Timestamp.now(),
    });

    return chat(chatUid);
  }

  Stream<QuerySnapshot> chat(String chatUid) {
    try {
      return _apiFireStore
          .collection('Chats')
          .doc(chatUid)
          .collection(chatUid)
          .orderBy('Timestamp', descending: true)
          .snapshots();
    } on Exception catch (e) {
          return null;
    }
  }

  Stream<QuerySnapshot> chats(String uid) {
    return _apiFireStore
        .collection('Chats')
        .where('Uid', arrayContains: uid)
        .orderBy('LastEditingTime', descending: true)
        .snapshots();
  }

  Future<void> escribirChat(String chatUID, String uid, String message,String deviceToken) async {
    await _apiFireStore.collection('Chats').doc(chatUID).update({
      'LastEditingTime': Timestamp.now(),
    });
    
    Map<String,dynamic> data = {
      'sendUid': uid,
      'Message': message,
      'Timestamp': Timestamp.now(),
    }; 
    
    await _apiFireStore
        .collection('Chats')
        .doc(chatUID)
        .collection(chatUID)
        .doc()
        .set(data);

    NotificationsApi notificationsApi = NotificationsApi();
    Map<String,dynamic> notificationData = await getUserInfo(uid)?? await getUserHealtInfo(uid);
    notificationData.addAll({'ChatUid':chatUID,'Message':message});
    notificationData.remove('FechaNacimiento');

    notificationsApi.sendAndRetrieveMessage(deviceToken,notificationData);

    
  }

  Future<void> actualizarData(Map<String, dynamic> data, String uid) {
    return _apiFireStore.collection(USUARIO).doc(uid).update(data);
  }

  Future<void> escribirChatImagen(chatUID, url, uid) async {
    await _apiFireStore.collection('Chats').doc(chatUID).update({
      'LastEditingTime': Timestamp.now(),
    });

    return _apiFireStore
        .collection('Chats')
        .doc(chatUID)
        .collection(chatUID)
        .doc()
        .set({
      'sendUid': uid,
      'ImageUrl': url,
      'Timestamp': Timestamp.now(),
    });
  }

  Future<bool> chatExist(String chatID) async{
    return await _apiFireStore.collection('Chats').doc(chatID).get().then((value) => value.exists);
  }

  Future<Map<String,dynamic>> getUserHealtInfo(String uid) async {
    return (await _apiFireStore.collection('ProfesionalSalud').doc(uid).get()).data();
  }
}
