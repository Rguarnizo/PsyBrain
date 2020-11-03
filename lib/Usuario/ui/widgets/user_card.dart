import 'dart:ui';

import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UsuarioBloc userBloc;
  final BuildContext context;

  UserCard({Key key, @required this.context, @required this.userBloc});

  @override
  Widget build(BuildContext context) {
    var userLogged = userBloc.getCurrentUser();
    // var phone;
    // userBloc.obtenerInformacion(userLogged.uid).then((documentSnapshot){
    //   phone = documentSnapshot.data()['phone'];
    // });

    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 18.0),
      height: 250.0,
      decoration: BoxDecoration(
        color: Color(0xFFf1e4e8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: UserInformation(userLogged),
          ),
          Container(
              margin: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 12.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(userLogged.email,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600))
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 18.0, right: 18.0),
            child: Divider(
              thickness: 1.4,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 12.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teléfono',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  //TODO: Cuando se mejore lo de los usuarios (informacion), se retorna el número telefonico
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text('300',
                            //snapshot.data['Telefono'],
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600));
                      } else {
                        return CupertinoActivityIndicator();
                      }
                    },
                    future: userBloc.getUserInfo(userLogged.uid),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget UserInformation(User userLogged) {
    var userLoggedId = userBloc.getCurrentUser().uid;
    return InkWell(
      onTap: () {
        Navigator.of(this.context).push(CupertinoPageRoute(builder: (context) {
          //TODO: Consulta, modificación de la información del usuario ciudadano
          return CupertinoPageScaffold(
              navigationBar:
                  CupertinoNavigationBar(middle: Text('Editar información')),
              child: Center(child: Text('Hola')));
        }));
      },
      child: Row(
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: userLogged.photoURL != null
                    ? NetworkImage(userLogged.photoURL)
                    : AssetImage('assets/imgs/user_defaulticon.jpg'),
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
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            snapshot.data['Nombres'] +
                                ' ' +
                                snapshot.data['Apellidos'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'SourceSansPro',
                                fontSize: 20),
                          );
                        } else {
                          return CupertinoActivityIndicator();
                        }
                      },
                      future: userBloc.getUserInfo(userLoggedId),
                    ),
                    Text(
                      'Usuario ciudadano',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SourceSansPro',
                          fontSize: 17),
                    ),
                  ])),
          Spacer(),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey,
            size: 20.0,
          )
        ],
      ),
    );
  }
}
