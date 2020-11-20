import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageImage extends StatelessWidget {
  final String title;
  final String description;
  final String imgURL;
  bool isUserMessage;
  DateTime timeStamp;

  ChatMessageImage(
      {Key key,
      this.isUserMessage,
      @required this.timeStamp,
      this.title,
      this.description,
      @required this.imgURL});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imgURL,
                height: 180,
                width: 300,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !isUserMessage ? Spacer() : null,
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    DateFormat('kk:mm').format(timeStamp),
                    style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
