import 'dart:ui';

import 'package:PsyBrain/ProfSalud/UI/screens/search_users_page.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/widgets/menu_widget.dart';
import 'package:PsyBrain/Usuario/ui/widgets/services_card.dart';
import 'package:PsyBrain/Usuario/ui/widgets/start_conversation_card.dart';
import 'package:PsyBrain/Usuario/ui/widgets/user_card.dart';
import 'package:PsyBrain/Usuario/ui/widgets/user_card_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageUser extends StatefulWidget {
  final UsuarioBloc userBloc;

  const HomePageUser({Key key, @required this.userBloc});

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house_alt),
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.bolt_horizontal_circle)),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.search)),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.plus_app),
                ),
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                builder: (BuildContext context) {
                  switch (index) {
                    case 0:
                      return CupertinoPageScaffold(
                        //TODO: Otros requirimientos relacionados con informacion principal, deberían ir aqui
                        child: Center(
                          child: CupertinoButton(
                              child: Text('Proximamente...'), onPressed: null),
                        ),
                      );
                      break;
                    case 1:
                      return CupertinoPageScaffold(
                          //TODO: UserChat history widgets here.
                          child: Column(
                        children: [
                          StartConversationCard(
                            context: context,
                          ),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: widget.userBloc.chats(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData && snapshot.data.size == 0) {
                                    return Center(
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 60),
                                            child: Text(
                                              'Aún no tienes mensajes. Busca alguien con quien chatear 🔍',
                                              style: TextStyle(color: Colors.grey),
                                            )));
                                  }

                                  return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                          snapshot.hasData ? snapshot.data.size : 0,
                                      itemBuilder: (context, index) {
                                        //print(snapshot.data.docs[index].id);
                                        //print(snapshot.data.docs[index].data()['LastEditingTime']);
                                        if (!snapshot.hasData) {
                                        } else {
                                          return Column(
                                            children: [
                                              UserCardChat(
                                                  info: snapshot.data.docs[index]),
                                            ],
                                          );
                                        }
                                      });
                                }),
                          )
                        ],
                      ));
                      break;
                    case 2:
                      return SearchUserPage();
                    case 3:
                      return CupertinoPageScaffold(
                        navigationBar: CupertinoNavigationBar(
                          middle: Text('Más'),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 120),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuWidget(
                                  title: 'Cuenta',
                                  description: 'Edita la información de tu cuenta',
                                  icon: CupertinoIcons.square_list,
                                ),
                                UserCard(context: context, userBloc: widget.userBloc),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: MenuWidget(
                                      title: 'Ayuda',
                                      description:
                                          'Consulta información sobre la app',
                                      icon: CupertinoIcons.question_circle),
                                ),
                                ServicesCard(),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: MenuWidget(
                                      title: 'Cerrar sesión',
                                      description:
                                          'Haz click en el ícono para cerrar sesión',
                                      icon: CupertinoIcons.square_arrow_right,
                                      action: () {
                                        widget.userBloc.signOut();
                                      }),
                                ),
                              ],
                            )),
                      );
                      break;
                  }
                  return null;
                },
              );
            },
          ),              
    );
  }
}
