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

class HomePageUser extends StatelessWidget {
  final UsuarioBloc userBloc;

  const HomePageUser({Key key, @required this.userBloc});
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
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 30,bottom: 30),
                          child: Column(
                            children: [
                              _mensajeBienvenida(),
                              SizedBox(height: 20,),
                              _registroDiarioCard(),
                              SizedBox(height: 20,),
                              _sentimientosDiariosCard(),
                              SizedBox(height: 20,),
                              _informacionSaludMentalCard(),
                              Image.asset('assets/imgs/dashboard.png'),
                              SizedBox(height: 10,),
                            ],
                          ),
                        )
                    ),
                  ));
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
                           child:  StreamBuilder<QuerySnapshot>(
                              stream: userBloc.chats(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.hasData? snapshot.data.size : 0,                              
                                  itemBuilder: (context, index) {                                                                
                                    print(snapshot.data.docs[index].id);                             
                                    print(snapshot.data.docs[index].data()['LastEditingTime']);
                                      if(!snapshot.hasData){
                                        
                                      }else{
                                      return Column(
                                        children: [
                                          UserCardChat(info: snapshot.data.docs[index]),                                          
                                        ],
                                      );
                                      }
                                    }                              
                                );
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
                            UserCard(context: context, userBloc: userBloc),
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
                                    userBloc.signOut();
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
  _mensajeBienvenida(){
    return Text(
      'Ten en cuenta las recomendaciones de los expertos para combatir el covid 19, usa tapabocas.',
      style: TextStyle(
          color: Colors.black,
          fontFamily: 'SourceSansPro',
          fontSize: 24,
          fontWeight: FontWeight.w400
      )
    );
  }
  _registroDiarioCard(){
    return Center(
      child: Card(
        color: Color(0xFFf1e4e8),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            InkWell(
              onTap: (){
              print('Esto debe llevar a una nueva vista') ;
            },
              child: const ListTile(
                leading: Icon(Icons.book),
                title: Text('Registro de situaciones postivas',
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                )),
                subtitle: Text('Si quieres anotar algo que te haya gustado puedes hacerlo aquí',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SourceSansPro',
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    )),
              ),
            ),

          ],
        ),
      ),
    );
  }
  _sentimientosDiariosCard(){
    return Center(
      child: Card(
        color: Color(0xFFf1e4e8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              onTap: (){
                print('Esto debe llevar a una nueva vista') ;
              },
              child: const ListTile(
                leading: Icon(Icons.emoji_emotions),
                title: Text('Libro de Sentimientos',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    )
                ),
                subtitle: Text('Aquí puedes anotar las emociones sentiste hoy',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SourceSansPro',
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    )),
              ),
            ),

          ],
        ),
      ),
    );
  }
  _informacionSaludMentalCard(){
    return Center(
      child: Card(
        color: Color(0xFFf1e4e8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              onTap: (){
                print('Esto debe llevar a una nueva vista') ;
              },
              child: const ListTile(
                leading: Icon(Icons.masks),
                title: Text('¿Estás en cuarentena?',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    )
                ),
                subtitle: Text('Consulta recomendaciones para pasar la cuarentena ',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SourceSansPro',
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    )),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
