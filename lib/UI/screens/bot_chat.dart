import 'dart:async';

import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/widgets/chat_message.dart';
import 'package:PsyBrain/Usuario/ui/widgets/chat_message_analysis.dart';
import 'package:PsyBrain/Usuario/ui/widgets/chat_message_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BotChat extends StatefulWidget {
  @override
  _BotChatState createState() => _BotChatState();
}

class _BotChatState extends State<BotChat> {
  String message;
  UsuarioBloc userBloc;
  ScrollController controller = new ScrollController();
  TextEditingController controllerMessage = new TextEditingController();
  List<Widget> conversation = [
    ChatMessage(
      timeStamp: Timestamp.now(),
      isUserMessage: false,
      message:
          "👾 Bienvenido a nuestro servicio de chat 🤖 \n Prueba decir cosas como: \n ¿Cuáles son los sintomas de COVID-19? \n Casos de COVID-19 en Reino Unido \n Reporte COVID-19 en Colombia ",
    ),
  ];
  bool analysisFlag = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    userBloc = BlocProvider.of(context);

    // Timer(
    //   Duration(seconds: 1),
    //   () => controller.jumpTo(controller.position.maxScrollExtent),
    // );

    getSessionID(userBloc);
    return Scaffold(
        backgroundColor: Color(0xFFf1e4e8),
        body: Stack(
          children: [
            Positioned(
                top: 15.0,
                child: Container(
                  height: screenSize.height - 100,
                  width: screenSize.width,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return conversation[index];
                    },
                    controller: controller,
                    itemCount: conversation.length,
                    // reverse: true,
                    // physics: BouncingScrollPhysics(),
                  ),
                )),
            Positioned(
                bottom: -10,
                height: 130,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.60),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        margin:
                            EdgeInsets.only(bottom: 72.5, left: 20.0, top: 10),
                        child: TextField(
                          controller: controllerMessage,
                          onChanged: (value) {
                            message = value;
                          },
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xFFf1e4e8),
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () async {
                                    controllerMessage.clear();
                                    //print(analysisFlag);
                                    FocusScope.of(context).unfocus();

                                    if (analysisFlag) {
                                      conversation.add(ChatMessageAnalysis(
                                        message: message,
                                        timeStamp: DateTime.now(),
                                        isUserMessage: true,
                                        response:
                                            userBloc.sendAnalysis(message),
                                      ));
                                    } else {
                                      conversation.add(ChatMessage(
                                        isUserMessage: true,
                                        message: message,
                                        timeStamp: Timestamp.now(),
                                      ));
                                    }

                                    controller.jumpTo(
                                        controller.position.maxScrollExtent +
                                            400);
                                    String sessionID =
                                        await getSessionID(userBloc);
                                    if (analysisFlag) {
                                      //Flujo de analisis de texto
                                      // await userBloc
                                      //     .sendAnalysis(message)
                                      //     .then((value) {
                                      //   conversation.add(ChatMessage(
                                      //     message: 'El mensaje es: ' +value.toString(),
                                      //     timeStamp: Timestamp.now(),
                                      //     isUserMessage: false,
                                      //   ));
                                      // });

                                    } else {
                                      //Flujo normal, conexion con Watson
                                      await userBloc
                                          .sendMessage(message, sessionID)
                                          .then((value) {
                                        if (value['output']['intents'][0]
                                                ['intent'] ==
                                            'professional_help') {
                                          analysisFlag = true;
                                          //print(analysisFlag);
                                        }
                                        //message = value['output']['generic']
                                        var responses =
                                            value['output']['generic'];
                                        responses.forEach((response) {
                                          if (response['response_type'] ==
                                              'text') {
                                            conversation.add(ChatMessage(
                                              isUserMessage: false,
                                              message: response['text'],
                                              timeStamp: Timestamp.now(),
                                            ));

                                            controller.jumpTo(controller
                                                .position.maxScrollExtent);
                                          } else if (response[
                                                  'response_type'] ==
                                              'image') {
                                            conversation.add(ChatMessageImage(
                                              timeStamp: DateTime.now(),
                                              imgURL: response['source'],
                                              description:
                                                  response['description'],
                                              isUserMessage: false,
                                              title: response['title'],
                                            ));
                                          }
                                          Timer(
                                            Duration(milliseconds: 100),
                                            () => controller.jumpTo(controller
                                                .position.maxScrollExtent),
                                          );
                                        });
                                        setState(() {});
                                      });
                                    }
                                  },
                                  child: Icon(CupertinoIcons.paperplane)),
                              hintText: 'Escribe algo ...',
                              fillColor: Color(0XFFcdd6dd).withOpacity(0.40),
                              focusColor: Color(0XFFcdd6dd),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.only(left: 14.0, right: 14.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25.0))),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }

  Future<String> getSessionID(UsuarioBloc userBloc) async {
    var sessionID = await userBloc.getSessionID();
    return sessionID['session_id'];
  }
}
