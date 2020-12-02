import 'package:PsyBrain/ProfSalud/UI/screens/search_users_page.dart';
import 'package:PsyBrain/ProfSalud/UI/widgets/relevant_words_card.dart';
import 'package:PsyBrain/ProfSalud/UI/widgets/user_card.dart';
import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/Usuario/ui/widgets/menu_widget.dart';
import 'package:PsyBrain/Usuario/ui/widgets/services_card.dart';
import 'package:PsyBrain/Usuario/ui/widgets/start_conversation_card.dart';
import 'package:PsyBrain/Usuario/ui/widgets/user_card_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageProfSalud extends StatelessWidget {
  final ProfSaludBloc userHealthBloc;

  HomePageProfSalud({Key key, @required this.userHealthBloc});
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
              icon: Icon(CupertinoIcons.chat_bubble),
            ),
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
                    child: Column(
                      children: [
                        RelevantWordsCard(
                          userHealthBloc: userHealthBloc,
                        )
                      ],
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
                            stream: userHealthBloc.chats(),
                            builder: (context, snapshot) {
                              //print('Aqui paso');
                              //print(snapshot);
                              if (!snapshot.hasData ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if(snapshot.data.size == 0){
                                  return Center(child:Text('Aún no tienes mensajes. Busca alguien con quien chatear 🧐'));
                                }
                                return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.hasData
                                        ? snapshot.data.size
                                        : 0,
                                    itemBuilder: (context, index) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        return Column(
                                          children: [
                                            UserCardChat(
                                              info: snapshot.data.docs[index],
                                            ),
                                          ],
                                        );
                                      }
                                    });
                              }
                            }),
                      )
                    ],
                  ));
                  break;
                case 2:
                  return SearchUserPage();
                  break;
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
                            UserCard(
                              context: context,
                              userHealthBloc: userHealthBloc,
                            ),
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
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(builder: (context) {
                                    //     return SignInScreen();
                                    //   },)
                                    // );
                                    userHealthBloc.signOut();
                                    // await Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) {
                                    //     return SignInScreen();
                                    //   },
                                    // )).then((value) => Navigator.of(context).pop());
                                    //
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

  String getUid(AsyncSnapshot snapshot, index) {
    return snapshot.data.docs[index].data()['Uid'][0] !=
            userHealthBloc.currentUser.uid
        ? snapshot.data.docs[index].data()['Uid'][0]
        : snapshot.data.docs[index].data()['Uid'][1];
  }
}
