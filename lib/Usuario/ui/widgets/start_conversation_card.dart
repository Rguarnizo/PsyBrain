import 'package:PsyBrain/Usuario/ui/screens/user_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartConversationCard extends StatelessWidget {
  final BuildContext context;

  StartConversationCard({Key key, @required this.context, infoUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(this.context).push(CupertinoPageRoute(builder: (context) {
              return CupertinoPageScaffold(
                navigationBar:
                      CupertinoNavigationBar(middle: Text('Chat')),
                child: UserChat(chatID: 'Hola',),
              );
            }));
          },
          child: Padding(
            padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
            child: Container(
              height: 80.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFf1e4e8),
                borderRadius: BorderRadius.circular(9.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Image(
                      image: AssetImage('assets/imgs/live_chat.png'),
                      height: 55.0,
                      width: 70,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¿Quieres hablar?',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Cuéntanos cualquier cosa 💪',
                            style: TextStyle(fontFamily: 'SourceSansPro'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
