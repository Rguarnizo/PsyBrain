import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreApi {
  final _apiFireStore = FirebaseFirestore.instance;
  final _apiFireAuth = FirebaseAuth.instance;
  final String PROFESIONALSALUD = 'ProfesionalSalud';
  final String CHATS = "Chats";

  Future<User> crearProfSalud(String email, String contrasena) async {
    UserCredential userRef = await _apiFireAuth.createUserWithEmailAndPassword(
        email: email, password: contrasena);

    return userRef.user;
  }

  Future<void> guardarInformacion(ProfSalud profSalud, String uid) {
    profSalud.id = uid;
    profSalud.imageURL = _apiFireAuth.currentUser.photoURL ??
        'https://www.pngkit.com/png/full/383-3836644_thinking-brain-png-png.png';
    return _apiFireStore
        .collection(PROFESIONALSALUD)
        .doc(uid)
        .set(profSalud.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid) {
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).get();
  }

  Stream<QuerySnapshot> getChats(String uid) {
    return _apiFireStore
        .collection('Chats')
        .where('Uid', arrayContains: uid)
        .orderBy('LastEditingTime', descending: true)
        .snapshots();
  }

  Future<void> actulizarData(Map<String, dynamic> data, String uid) {
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).update(data);
  }

  Stream<QuerySnapshot> getListUsers(String query) {
    String limit;
    if (query != '') {
      final strFrontCode = query.substring(0, query.length - 1);
      final strEndCode = query.split('').last;
      limit = strFrontCode + String.fromCharCode(strEndCode.codeUnitAt(0) + 1);
    }
    return _apiFireStore
        .collection('Usuario')
        .where('Nombres', isGreaterThanOrEqualTo: query)
        .where('Nombres', isLessThan: limit)
        .snapshots();
  }

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

  Future<bool> chatExist(String chatID)async {
      return await _apiFireStore.collection('Chats').doc(chatID).get().then((value) => value.exists);
  }
}
