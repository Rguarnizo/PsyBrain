
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataBaseApi {

  FirebaseFirestore dbRef = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getDocumentInfo({@required String collection,@required String document}){
    return dbRef.collection(collection).doc(document).get();
  }

  Future<void> updateInfo({@required String collection,@required String document,@required data}){
    return dbRef.collection(collection).doc(document).set(data);
  }

  

}