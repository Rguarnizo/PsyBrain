import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FireStoreApi {
  final _apiFireStore = FirebaseFirestore.instance;
  final _apiFireAuth = FirebaseAuth.instance;
  final String PROFESIONALSALUD = 'ProfesionalSalud';
  final String CHATS = "Chats";

  /// Crea un usuario con el email respectivo y la contraseña respectiva usando la Logica de Firebase Authentication.
  Future<User> crearProfSalud(String email, String contrasena) async {
    UserCredential userRef = await _apiFireAuth.createUserWithEmailAndPassword(
        email: email, password: contrasena);

    return userRef.user;
  }

  /// Guarda la información de un usuario con el id especificado y la instancia de un Profesional de la salud, mediante los metodos de
  /// FireStore.
  Future<void> guardarInformacion(ProfSalud profSalud, String uid) {
    profSalud.id = uid;
    profSalud.imageURL = _apiFireAuth.currentUser.photoURL ??
        'https://www.pngkit.com/png/full/383-3836644_thinking-brain-png-png.png';
    return _apiFireStore
        .collection(PROFESIONALSALUD)
        .doc(uid)
        .set(profSalud.json());
  }

  /// Obtiene la información de un usuario Profesional de la salud concreto con el uid especificado, usando los metodos de 
  /// FireStore.
  Future<DocumentSnapshot> obtenerInformacion(String uid) {
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).get();
  }

  /// Retorna un Stream de los chats de un Usuario especificado en el uid.
  Stream<QuerySnapshot> getChats(String uid) {
    return _apiFireStore
        .collection('Chats')
        .where('Uid', arrayContains: uid)
        .orderBy('LastEditingTime', descending: true)
        .snapshots();
  }

  /// Actualiza la información de un Usuario especificado por el uid y el Json correspondiente.
  Future<void> actulizarData(Map<String, dynamic> data, String uid) {
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).update(data);
  }

  /// Obtiene la lista completa de usuarios con los cuales su nombre empiece por la query descrita.
  Stream<QuerySnapshot> getListUsers(String query) {
    String limit;
    if (query != '') {
      final strFrontCode = query.substring(0, query.length - 1);
      final strEndCode = query.split('').last;
      limit = strFrontCode + String.fromCharCode(strEndCode.codeUnitAt(0) + 1);
    }

    Stream<QuerySnapshot> users =_apiFireStore
        .collection('Usuario')
        .where('Nombres', isGreaterThanOrEqualTo: query)
        .where('Nombres', isLessThan: limit)
        .snapshots();
    

        return users;
  }

  ///Obtiene los usuarios Profesional de la salud los cuales empicen con el nombre tal cual la query.
  Stream<QuerySnapshot> getListHealts(String query) {
    String limit;
    if (query != '') {
      final strFrontCode = query.substring(0, query.length - 1);
      final strEndCode = query.split('').last;
      limit = strFrontCode + String.fromCharCode(strEndCode.codeUnitAt(0) + 1);
    }

    Stream<QuerySnapshot> healts =_apiFireStore
        .collection('ProfesionalSalud')
        .where('Nombres', isGreaterThanOrEqualTo: query)
        .where('Nombres', isLessThan: limit)
        .snapshots();
  
        return healts;
  }

  /// Inicia el chat con los usuarios que se especifiquen los dos uids y con el mensaje especificado, guarda un timestamp 
  /// actual y los dos uids de los usuarios.
  Future<void> iniciarChat(
      String anotherUserUid, String uid, String message) async {
    await _apiFireStore.collection('Chats').doc('$uid-$anotherUserUid').set({
      'Uid': [uid, anotherUserUid],
      'LastEditingTime': Timestamp.now(),
    });

    return _apiFireStore
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
  }

  /// Obtiene la información de todos los chats que tenga el usuario con el uid correspondiente.
  Future<List<String>> getChatsPS(String currentUserID) async {
    List<String> chatRecount = [];
    var totalChatSnap = await _apiFireStore.collection(CHATS).get();
    for (var i = 0; i < totalChatSnap.docs.length; i++) {
      var query = totalChatSnap.docs[i].id.split('-');
      for (var j = 0; j < query.length; j++) {
        if (query[j] == currentUserID) {
          var str = await getChatsAux(totalChatSnap.docs[i], currentUserID);
          chatRecount.add(str);
        }
      }
    }
    return chatRecount;
  }

  Future<String> getChatsAux(
      QueryDocumentSnapshot chat, String currentUserID) async {
    String chatRecopilationString = "";
    var chatSnap = await _apiFireStore
        .collection(CHATS)
        .doc(chat.id)
        .collection(chat.id)
        .get();
    chatSnap.docs.forEach((element) {
      if (element.data()['Message'] != null) {
        chatRecopilationString += element.data()['Message'] + ' ';
      }
    });
    return chatRecopilationString;
  }

  /// Revisa si existe el chat con el UID especificado. True si existe, false si no.
  Future<bool> chatExist(String chatID)async {
      return await _apiFireStore.collection('Chats').doc(chatID).get().then((value) => value.exists);
  }

  /// Guarda la calificación hacia un Profesional de la salud en un array de calificaciones.
  Future<void> calificarProfSalud(String uid, double calificacion) async{
    
    List data = (await obtenerInformacion(uid)).data()['Calificaciones'];
    data??= [];

    data.add(calificacion);
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).update({
      'Calificaciones': data,
    });
  }
}
