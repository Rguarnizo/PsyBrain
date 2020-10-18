import 'package:PsyBrain/Pages/user_chat.dart';
import 'package:PsyBrain/utils/login_buttons.dart';
import 'package:PsyBrain/utils/sing_in_firebase.dart';
import 'package:flutter/material.dart';


class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 122.35, left: 30.0, right: 30.0),
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titulo(),
            _subtitle(),
            _image(),
            Container(
              height: 108.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _emailInput(),
                  _passwordInput(),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      botonEntrar(context),
                      botonGoogle(context),
                      botonCrearCuenta(),                                  
                    ],
                  ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titulo() {

    return Text(
      '¡Bienvenido de nuevo!',
      style: TextStyle(
          color: Colors.black,
          fontFamily: 'SourceSansPro',
          fontSize: 28.2,
          fontWeight: FontWeight.w400
          //fontWeight: FontStyle.italic,
          ),
    );
  }

  Widget _subtitle() {
    return Text(
      'Ingresa para continuar',
      style: TextStyle(
          color: Colors.grey,
          //fontWeight: FontWeight.w700,
          fontFamily: 'SourceSansPro',
          fontSize: 18.2,
          fontWeight: FontWeight.w300),
    );
  }

  Widget _image() {
    return Container(
      margin: EdgeInsets.only(
          left: 30.0, right: 30.0, top: 60.5, bottom: 30.5),
      child: Image.asset('assets/imgs/login_img.png'));
  }

  Widget _emailInput() {

    return TextField(
      cursorColor: Color(0xFFf1e4e8),
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.alternate_email),
          hintText: 'Ingresa aqui tu email',
          contentPadding: EdgeInsets.only(left: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xFFceb1be), width: 2.0),
            borderRadius: BorderRadius.circular(9.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9))),
    );
  }

  Widget _passwordInput() {
    return TextField(
      cursorColor: Color(0xFFf1e4e8),
      obscureText: true,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.lock),
          hintText: 'Ingresa aqui tu contraseña ',
          contentPadding: EdgeInsets.only(left: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xFFceb1be), width: 2.0),
            borderRadius: BorderRadius.circular(9.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9))),
    );
  }

    Widget botonEntrar(BuildContext context) {
    return MyButton(
      buttonName: 'Entrar',
      gradientColors: [Color(0xFFceb1be)],
      textColor: Colors.white,
      width: 110,
      withShadow: true,
      action: () {
        print('Hola');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserChat()));
      });
  }
  

  Widget botonGoogle(BuildContext context){
    return MyButton(
        gradientColors: [Color(0xFFceb1be)],
        withShadow: false,
        width: 50,
        image: AssetImage('assets/imgs/google_icon.png'),
        action: () async {
          final userName = await signInWithGoogle().whenComplete((){
            Navigator.of(context).pushNamed('UserChat');            
          });
          print(userName);
        },
      );
  }

    Widget botonCrearCuenta() {
      return MyButton(
        action: () {},
        buttonName: 'Crea tu cuenta',
        gradientColors: [Color(0xFFf1e4e8)],
        textColor: Color(0xFFCEB1BE),
        width: 150,
        withShadow: false,
    );
  }
}

  


