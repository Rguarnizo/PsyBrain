
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  String image;
  bool isUserMessage;
  Timestamp timeStamp;

  ChatMessage({Key key, @required this.message, this.isUserMessage, this.timeStamp, this.image});


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
              message?? '',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            hasImage()? FadeInImage.assetNetwork(placeholder: 'assets/imgs/loading2.gif', image: image): Container(),            
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                dateMessage(),                
                style: TextStyle(fontSize: 13.0, color: Colors.grey),
              ),
            ),
          ],
        ));
  }

  String dateMessage() {
    DateTime dateTime = timeStamp.toDate();
    String hora = DateFormat.jm().format(dateTime);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year} / $hora';
  }

  bool hasImage(){
    bool hasImage = image.runtimeType == String;
    return hasImage;
  }
}
