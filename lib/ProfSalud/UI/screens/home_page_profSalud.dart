
import 'package:PsyBrain/ProfSalud/UI/widgets/user_card.dart';
import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/Usuario/ui/widgets/menu_widget.dart';
import 'package:PsyBrain/Usuario/ui/widgets/services_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageProfSalud extends StatelessWidget {
  final ProfSaludBloc userHealthBloc;

  HomePageProfSalud(
      {Key key, @required this.userHealthBloc});
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
                      child:
                          CupertinoButton(child: Text('Hola'), onPressed: null),
                    ),
                  );
                  break;
                case 1:
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
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
