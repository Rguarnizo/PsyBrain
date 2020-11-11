import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  bool isUserMessage;

  ChatMessage({Key key, @required this.message, this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: !isUserMessage
            ? EdgeInsets.only(top: 0, right: 80.0, bottom: 20)
            : EdgeInsets.only(top: 0, left: 80.0, bottom: 20),
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
              message,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'HERE HOUR',
                style: TextStyle(fontSize: 10.0, color: Colors.grey),
              ),
            ),
          ],
        ));
  }
}
