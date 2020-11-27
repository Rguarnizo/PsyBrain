import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageAnalysis extends StatelessWidget {
  final String message;
  bool isUserMessage;
  DateTime timeStamp;
  final Future response;

  ChatMessageAnalysis(
      {Key key,
      @required this.message,
      this.isUserMessage,
      @required this.timeStamp,
      @required this.response});

  @override
  Widget build(BuildContext context) {
    List<Widget> message = [messageBubble()];
    if (isUserMessage) {
      message.add(messageAvatar());
    } else {
      message.insert(0, messageAvatar());
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 15.0),
      width: MediaQuery.of(context).size.width - 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: message,
      ),
    );
  }

  Widget messageAvatar() {
    if (isUserMessage) {
      return CircleAvatar(
        radius: 20.0,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFceb1be),
      );
    } else {
      return CircleAvatar(
        radius: 20.0,
        child: Icon(
          CupertinoIcons.bolt_horizontal_fill,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFceb1be),
      );
    }
  }

  Widget messageBubble() {
    return Container(
        margin: !isUserMessage
            ? EdgeInsets.only(top: 0, right: 30.0, bottom: 0)
            : EdgeInsets.only(top: 0, left: 20.0, bottom: 0),
        padding: EdgeInsets.all(
          15.0,
        ),
        //height: 100.0,
        width: 275.80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: !isUserMessage
              ? [
                  BoxShadow(
                      blurRadius: 11.0,
                      color: Colors.black12,
                      offset: Offset(7, 7)),
                ]
              : [],
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: !isUserMessage
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message ?? 'null',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    DateFormat('kk:mm').format(timeStamp),
                    style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return processingData();
                          break;
                        case ConnectionState.waiting:
                          return processingData();
                          break;
                        case ConnectionState.active:
                          return processingData();
                          break;
                        case ConnectionState.done:
                          switch (snapshot.data['sentiment']['document']
                              ['label']) {
                            case 'positive':
                              return dialogSquare(
                                  Color(0xFF38ef7d), 'Positivo');
                              break;
                            case 'negative':
                              return dialogSquare(
                                  Color(0XFFDA4453), 'Negativo');
                            case 'neutral':
                              return dialogSquare(Color(0XFFFFE000), 'Neutral');
                              break;
                            default:
                              return dialogSquare(
                                  Colors.grey, 'No se pudo clasificar');
                              break;
                          }

                          break;
                      }
                    },
                    future: response,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget processingData() {
    return Container(
      width: 120,
      height: 27.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey, width: 2.0)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CupertinoActivityIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Procesando',
              style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }

  Widget dialogSquare(Color color, String text) {
    return Container(
        width: 100,
        height: 27.5,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(blurRadius: 5.0, color: color, offset: Offset(2, 2))
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
                color: Colors.white),
          ),
        ));
  }
}
