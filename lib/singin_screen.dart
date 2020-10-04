import 'package:PsyBrain/user_chat.dart';
import 'package:flutter/material.dart';

import 'login_buttons.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
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
                  ),
                  TextField(
                    cursorColor: Color(0xFFf1e4e8),
                    obscureText: true,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.face),
                        hintText: 'Ingresa aqui tu contraseña ',
                        contentPadding: EdgeInsets.only(left: 14.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFceb1be), width: 2.0),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9))),
                  ),
                ],
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
                          print('Hola');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserChat()));
                        }),
                    MyButton(
                      gradientColors: [Color(0xFFceb1be)],
                      withShadow: false,
                      width: 50,
                      image: AssetImage('assets/imgs/google_icon.png'),
                    ),
                    MyButton(
                      buttonName: 'Crea tu cuenta',
                      gradientColors: [Color(0xFFf1e4e8)],
                      textColor: Color(0xFFCEB1BE),
                      width: 155,
                      withShadow: false,
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
