import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/Usuario/ui/screens/user_chat.dart';
import 'package:PsyBrain/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserProfile extends StatelessWidget {
  UserProfile({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;
  ProfSaludBloc blocProfSalud;

  @override
  Widget build(BuildContext context) {
    blocProfSalud = BlocProvider.of<ProfSaludBloc>(context);
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: Text(
                      data['Nombres'],
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  hasCalification()
                      ? Center(
                          child: Column(
                            children: [
                              Text('¡Puntua la atención!'),
                              RatingBar.builder(
                                initialRating:
                                    promedioCalificacion(data['Calificaciones']),
                                itemSize: 30,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  FlutterIcons.brain_mco,
                                  color: color[900],
                                ),
                                maxRating: 100,
                                onRatingUpdate: (value) async {
                                  await blocProfSalud.calificarProfSalud(
                                      data['Uid'], value);
                                  await Future.delayed(Duration(microseconds: 500));
                                  showDialog(
                                      context: context,
                                      child: Dialog(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child:Column(
                                              mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.favorite,color: Colors.red,),
                                                    Text('Tu valoración ha sido enviada.',style: TextStyle(fontSize: 18),),
                                                    Text('Gracias',style: TextStyle(fontSize: 16)),
                                                    Text('Así podremos mejorar dia tras dia'),
                                                  ],
                                                ),                                         
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Telefono:  ${data['Telefono']}',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Correo: ${data['Correo']}',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                          onPressed: () async {
                            String currentUserId =
                                blocProfSalud.currentUser.uid;
                            if (await blocProfSalud.chatExist(
                                    '${currentUserId}-${data['Uid']}') ||
                                await blocProfSalud.chatExist(
                                    '${data['Uid']}-${currentUserId}')) {
                              String chatID = await blocProfSalud.chatExist(
                                      '${currentUserId}-${data['Uid']}')
                                  ? '${currentUserId}-${data['Uid']}'
                                  : '${data['Uid']}-${currentUserId}';
                              Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (context) {
                                return CupertinoPageScaffold(
                                  navigationBar: CupertinoNavigationBar(
                                      middle: Text('Chat')),
                                  child: UserChat(
                                    chatID: chatID,
                                  ),
                                );
                              }));
                            } else {
                              blocProfSalud.iniciarChat(data['Uid'], '...');
                              Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (context) {
                                return CupertinoPageScaffold(
                                  navigationBar: CupertinoNavigationBar(
                                      middle: Text('Chat')),
                                  child: UserChat(
                                    chatID: '${currentUserId}-${data['Uid']}',
                                  ),
                                );
                              }));
                            }
                          },
                          child: Text(
                            'Chatear',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Salir',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            )),
        Positioned(
          top: 200,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(data['ImageURL']),
          ),
        )
      ],
    );
  }

  bool hasCalification() {
    dynamic hasCalificaciones = data['Calificaciones'] ?? '';
    if (hasCalificaciones.runtimeType == String) {
      return false;
    } else {
      return true;
    }
  }

  double promedioCalificacion(List calificaciones) {
    double sum = calificaciones.reduce((value, element) => value + element);
    return sum / calificaciones.length;
  }
}
