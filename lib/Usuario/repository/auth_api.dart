import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthAPI {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<auth.UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication gSA =
        await googleSignInAccount.authentication;

    final auth.GoogleAuthCredential credential =
        auth.GoogleAuthProvider.credential(
            accessToken: gSA.accessToken, idToken: gSA.idToken);

    return await _auth.signInWithCredential(credential);
  }

  void signOut() async {
    await _auth.signOut().then((onValue) => print("Sesión finalizada"));
    googleSignIn.signOut();
  }

  Future<auth.UserCredential> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on auth.FirebaseAuthException catch (e) {
      switch (e.code) {

        // TODO: Separar Logica de interfaz.
        /*
        case "user-not-found":
          SignInScreen.showDialogAlert(context, 'Usuario no encontrado',
              'No existe un usuario asociado a ese correo 😢. Intenta registrarte');
          break;
        case "wrong-password":
          SignInScreen.showDialogAlert(context, 'Contraseña incorrecta',
              'La contraseña es incorrecta 😢. Intenta de nuevo');
          break;
          */
      }
      return null;
    }
  }

  auth.User getCurrentUser(){
    return _auth.currentUser;
  }
}
