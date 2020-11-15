import 'dart:ui';

import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/screens/user_chat.dart';
import 'package:PsyBrain/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserCardChat extends StatelessWidget {
  QueryDocumentSnapshot info;
  bool isUserHealt;
  String uidUserInfo;

  UserCardChat({Key key, this.info}) : super(key: key);

  UsuarioBloc userBloc;
  ProfSaludBloc profSaludBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UsuarioBloc>(context);
    profSaludBloc = BlocProvider.of<ProfSaludBloc>(context);
    bool isRead = false;
    return FutureBuilder(
        future: typeOfUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isUserHealt = snapshot.data;

            return FutureBuilder(
              future: isUserHealt
                  ? profSaludBloc.getUserHealthInfo(uidUserInfo)
                  : userBloc.getUserInfo(uidUserInfo),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: isRead ? color[50] : null,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            GestureDetector(
                                child: CircleAvatar(
                              child: Image.network('https://www.pngkit.com/png/detail/869-8693356_viaja-a-travs-de-los-libros-brain-cartoon.png'),
                              maxRadius: 30,
                            ),
                            onTap: () => print('Usuario Data'),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width - 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data['Nombres'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'SourceSansPro',
                                        ),
                                      ),
                                      Text(
                                        snapshot.data['Licencia'] == null
                                            ? 'Amigo'
                                            : 'Médico',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'SourceSansPro',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'UltimoMensaje',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontFamily: 'SourceSansPro',
                                        ),
                                      ),
                                      Text(
                                        getLastTime(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontFamily: 'SourceSansPro',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                        onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) {
                return CupertinoPageScaffold(
                  navigationBar:
                        CupertinoNavigationBar(middle: Text('Chat')),
                  child: UserChat(chatID: info.id,),
                );
                }
                    )
                    );
                  },
                  );
                }
                return Container();
              },
            );
          }else{
            return Container();
          }
        });
  }

  String getLastTime() {
    DateTime time = info.data()['LastEditingTime'].toDate();
    String hora = DateFormat.jm().format(time);
    return '$hora';
  }

  Future<bool> typeOfUser() async {
    if (info.data()['Uid'][0] != userBloc.currentUser.uid) {
      uidUserInfo = info.data()['Uid'][0];
      return await profSaludBloc.profSaludRegistrado(info.data()['Uid'][0]);
    } else {
      uidUserInfo = info.data()['Uid'][1];
      return await profSaludBloc.profSaludRegistrado(info.data()['Uid'][1]);
    }
  }
}
