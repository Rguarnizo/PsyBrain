
import 'package:PsyBrain/ProfSalud/UI/register_page_profSalud.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/screens/home_page.dart';
import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();

  static void showDialogAlert(
      BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}

class _SignInScreenState extends State<SignInScreen> {
  UsuarioBloc userBloc;
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  void validateAndSave() {
    final form = formKey.currentState;
    form.validate()
        ? {
            form.save(),
            print('Form valid. Email : ${_email}, Password: $_password}')
          }
        : print('Form invalid');
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UsuarioBloc>(context);

    return _handleSession(context);
  }

  Widget _handleSession(BuildContext context) {
    return StreamBuilder(
        stream: userBloc.userStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return signInUI(context);
          } else {
            return HomePage();
          }
        });
  }

  Widget signInUI(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 122.35, left: 30.0, right: 30.0),
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Bienvenido de nuevo!',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSansPro',
                  fontSize: 28.2,
                  fontWeight: FontWeight.w400
                  //fontWeight: FontStyle.italic,
                  ),
            ),
            Text(
              'Ingresa para continuar',
              style: TextStyle(
                  color: Colors.grey,
                  //fontWeight: FontWeight.w700,
                  fontFamily: 'SourceSansPro',
                  fontSize: 18.2,
                  fontWeight: FontWeight.w300),
            ),
            Container(
                margin: EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 60.5, bottom: 30.5),
                child: Image.asset('assets/imgs/login_img.png')),
            Container(
              height: 108.0,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      validator: (value) {
                        value.isEmpty
                            ? SignInScreen.showDialogAlert(
                                context,
                                'Campo vacío',
                                'El campo email no puede estar vacío😊')
                            : null;
                        return null;
                      },
                      onSaved: (value) => _email = value,
                      cursorColor: Color(0xFFf1e4e8),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.alternate_email),
                          hintText: 'Ingresa aqui tu email',
                          contentPadding: EdgeInsets.only(left: 14.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFceb1be), width: 2.0),
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                    TextFormField(
                      validator: (value) {
                        value.isEmpty
                            ? SignInScreen.showDialogAlert(
                                context,
                                'Campo vacío',
                                'El campo contraseña no puede estar vacío😊')
                            : null;
                        return null;
                      },
                      onSaved: (value) => _password = value,
                      cursorColor: Color(0xFFf1e4e8),
                      obscureText: true,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.face),
                          hintText: 'Ingresa aqui tu contraseña ',
                          contentPadding: EdgeInsets.only(left: 14.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFceb1be), width: 2.0),
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(
                        buttonName: 'Entrar',
                        gradientColors: [Color(0xFFceb1be)],
                        textColor: Colors.white,
                        width: 115,
                        withShadow: true,
                        action: () {
                          validateAndSave();
                          if (_email != '' && _password != '') {
                            userBloc.signInWithEmailAndPassword(
                                _email, _password, context);
                          }
                        }),
                    MyButton(
                      gradientColors: [Color(0xFFceb1be)],
                      withShadow: false,
                      width: 50,
                      image: AssetImage('assets/imgs/google_icon.png'),
                      action: () {
                        userBloc.signOut();
                        userBloc.signInGoogle();
                      },
                    ),
                    MyButton(
                      buttonName: 'Crea tu cuenta',
                      gradientColors: [Color(0xFFf1e4e8)],
                      textColor: Color(0xFFCEB1BE),
                      width: 155,
                      withShadow: false,
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPageProfSalud()));
                      },
                    ),

                  ],
                ),


              ),
            ),
          ],
        ),
      ),
    );
  }
}
