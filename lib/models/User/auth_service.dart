
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    UserCredential authResult = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: gSA.idToken, accessToken: gSA.accessToken));
    User user = authResult.user;
    return user;
  }

  void signOut() async {
    await _auth.signOut().then((onValue) => print("Sesión finalizada"));
    googleSignIn.signOut();
  }

  Future<UserCredential> createAccount({@required email ,@required password}){
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<User> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential auth = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = auth.user;
      assert(user != null);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":                  
          break;
        case "ERROR_USER_NOT_FOUND":
          break;
        case "ERROR_INVALID_EMAIL":        
          break;
        case "ERROR_WRONG_PASSWORD":        
          break;
      }
      return null;
    }
  }
}
