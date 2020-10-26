import 'package:PsyBrain/User/ui/singin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  void signOutGoogle() async {
    await _auth.signOut().then((onValue) => print("Sesión finalizada"));
    googleSignIn.signOut();
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
          SignInScreen.showDialogAlert(
              context, 'Error en el campo email', 'El formato del email es incorrecto 😢');
          break;
        case "ERROR_USER_NOT_FOUND":
          SignInScreen.showDialogAlert(context, 'Usuario no encontrado',
              'No encontramos tus datos 😢. Intenta registrarte');
          break;
        case "ERROR_INVALID_EMAIL":
          SignInScreen.showDialogAlert(context, 'Error en el email',
              'El email ingresado no es válido 😢');
          break;
        case "ERROR_WRONG_PASSWORD":
          SignInScreen.showDialogAlert(context, 'Error en la contraseña',
              'La contraseña ingresada no es válida 😢');
          break;
      }
      return null;
    }
  }
}
