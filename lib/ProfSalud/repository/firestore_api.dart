
import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreApi{


  final _apiFireStore = FirebaseFirestore.instance;
  final _apiFireAuth = FirebaseAuth.instance;
  final String PROFESIONALSALUD = 'ProfesionalSalud';

  Future<User> crearProfSalud(String email, String contrasena) async {
    
  
    UserCredential userRef = await _apiFireAuth.createUserWithEmailAndPassword(email: email, password: contrasena);

    return userRef.user;
  }


  Future<void> guardarInformacion(ProfSalud profSalud,String uid){
      profSalud.id = uid;
      profSalud.imageURL = _apiFireAuth.currentUser.photoURL?? 'https://www.pngkit.com/png/full/383-3836644_thinking-brain-png-png.png';
      return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).set(profSalud.json());
  }

  Future<DocumentSnapshot> obtenerInformacion(String uid){
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).get();
  }


  Stream<QuerySnapshot> getChats(String uid){
    return _apiFireStore.collection('Chats').where('Uid',arrayContains: uid).orderBy('LastEditingTime',descending: true).snapshots();  
  }

  Future<void> actulizarData(Map<String,dynamic> data,String uid){
    return _apiFireStore.collection(PROFESIONALSALUD).doc(uid).update(data);
  }

  Stream<QuerySnapshot> getListUsers(String query) {
    String limit;
    if(query != ''){
    final strFrontCode = query.substring(0, query.length - 1);
    final strEndCode = query.split('').last;
    limit =
      strFrontCode + String.fromCharCode(strEndCode.codeUnitAt(0) + 1);
    }
    return _apiFireStore.collection('Usuario').where('Nombres',isGreaterThanOrEqualTo: query).where('Nombres',isLessThan: limit).snapshots();
  } 

  Future<void> iniciarChat(String anotherUserUid, String uid,String message) async {
    
    await _apiFireStore.collection('Chats').doc('$uid-$anotherUserUid').set({
      'Uid': [uid,anotherUserUid],
      'LastEditingTime': Timestamp.now(),
    });

    return _apiFireStore.collection('Chats').doc('$uid-$anotherUserUid').collection('$uid-$anotherUserUid').doc().set({
      'sendUid'  :  uid,
      'reciveUid': anotherUserUid,
      'Message'  : message,
      'Timestamp': Timestamp.now(),
    });
  }

}