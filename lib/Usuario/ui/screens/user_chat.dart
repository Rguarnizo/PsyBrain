import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/widgets/chat_message.dart';
import 'package:PsyBrain/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserChat extends StatefulWidget {
  String chatID;
  String sendUserUid;


   UserChat({this.chatID,this.sendUserUid});

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> { 
 
  UsuarioBloc userBloc;

  TextEditingController controllerMessage = TextEditingController();
  ScrollController scrollController = ScrollController();



  //TODO: Move API Connection to UserBloc, repo etc.
  String APIURL =
      "https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/e36711d7-84aa-4b47-814a-6173e3095506/v1/analyze?version=2018-11-16";

  Future<Map<String, dynamic>> getInfoML(String text) async {
    var response;
    var data = json.encode({
      "text": text,
      "features": {
        "sentiment": {},
        "keywords": {"emotion": true}
      }
    });
    response = await http.post(APIURL,
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic YXBpa2V5OnpYOG41WTNOWVF0MFVkcVpJNVp5V2NFM3Bxamo0UWtveVI4SlFoSkItQ2FW',
          'Content-Type': 'application/json'
        },
        body: data);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {    
    
    userBloc = BlocProvider.of<UsuarioBloc>(context);
    return Scaffold(
        backgroundColor: Color(0xFFf1e4e8),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 125),
              child: StreamBuilder(
                  stream: userBloc.chat(widget.chatID),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {                    
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.size,
                        itemBuilder: (context, index) {
                          return ChatMessage(
                              isUserMessage: isUserMessage(snapshot,index),
                              message:
                                  snapshot.data.docs[index].data()['Message'],
                                  timeStamp:snapshot.data.docs[index].data()['Timestamp']);
                        },
                      );
                    }
                  }),
            ),
            Positioned(
              bottom: -40,
              height: 160,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.60),
                    color: Colors.white),
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    controller: controllerMessage,
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xFFf1e4e8),
                    decoration: InputDecoration(
                        suffix: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.emoji_emotions,
                                color: color[700],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.send,
                                color: color[900],
                              ),
                              onTap: () {
                                if(controllerMessage.text.isNotEmpty){                                                                  
                                userBloc.escribirChat(
                                    widget.chatID, controllerMessage.text);
                                scrollController.jumpTo(
                                    scrollController.position.maxScrollExtent +
                                        40.0);
                                controllerMessage.clear();
                                }                                                      
                                }
                            ),
                          ],
                        ),
                        hintText: 'Escribe algo ...',
                        fillColor: Color(0XFFcdd6dd).withOpacity(0.40),
                        focusColor: Color(0XFFcdd6dd),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: 14.0, right: 14.0, bottom: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25.0))),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  bool isUserMessage(snapshot,index) {
    return userBloc.currentUser.uid.compareTo(snapshot.data.docs[index].data()['sendUid']) == 0;
  }
}
