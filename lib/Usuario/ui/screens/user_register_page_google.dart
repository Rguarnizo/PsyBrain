import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/widgets/register_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserRegisterPageGoogle extends StatelessWidget {
  final User userInfo;
  final UsuarioBloc userBloc;

  UserRegisterPageGoogle({
    Key key,
    @required this.userInfo, @required this.userBloc,
  });

  @override
  Widget build(BuildContext context) {
    //var userLogged = userBloc.getCurrentUser();
    //var height= MediaQuery.of(context).size.height;
    //var userInfo = userCredential.user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Completa tu registro',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              Text('Completa la información de tu usuario',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(userInfo.photoURL),
                        ),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userInfo.displayName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 20),
                              ),
                              Text(
                                userInfo.email,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 17),
                              ),
                            ])),
                  ],
                ),
              ),
              RegisterForm(
                displayName: userInfo.displayName,
                email: userInfo.email,
                uid: userInfo.uid,
                userBloc: userBloc,
              )
            ]),
      ),
    );
  }
}
