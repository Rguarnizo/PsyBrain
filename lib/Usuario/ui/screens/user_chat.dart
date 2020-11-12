import 'dart:convert';
import 'dart:io';

import 'package:PsyBrain/Usuario/ui/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserChat extends StatefulWidget {
  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  String message;

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
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFFf1e4e8),
        body: Stack(
          children: [
            Positioned(
                top: 95.0,
                child: Container(
                  padding: EdgeInsets.only(left: 15.0),
                  height: screenSize.height - 230,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ChatMessage(
                            isUserMessage: false,
                            message:
                                'Ut dolor mollit non ullamco sit tempor cupidatat sint ipsum labore consequat. Ullamco minim excepteur ea sit laboris dolor velit. Nostrud sit non fugiat id pariatur ullamco duis eiusmod fugiat reprehenderit sit est. Deserunt quis veniam nisi ullamco aliquip aute in nostrud ut nulla minim cupidatat dolore. Velit nostrud ad Lorem voluptate do consequat tempor incididunt adipisicing anim nisi minim veniam. Ut aliquip minim sint et. Ex velit ea proident irure excepteur consectetur quis aliqua nulla id.'),
                        ChatMessage(
                            isUserMessage: true,
                            message:
                                'Deserunt ex excepteur ea ullamco Lorem est ullamco. Proident commodo excepteur irure eu pariatur ex proident ullamco aliquip consequat irure labore aliquip. Adipisicing irure veniam dolor duis tempor voluptate. Cupidatat aliquip incididunt do cillum ipsum. Id do ullamco anim laboris occaecat sit enim adipisicing pariatur consectetur ex do enim. Aute incididunt excepteur Lorem minim nulla esse anim aute dolore duis. Reprehenderit enim minim pariatur occaecat aliqua consectetur duis consectetur ipsum et laborum.'),
                        ChatMessage(
                          message: this.message ?? 'Buenas buenas',
                          isUserMessage: true,
                        )
                      ],
                    ),
                  ),
                )),
            Positioned(
                bottom: -10,
                height: 150,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.60),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        width: 300,
                        margin:
                            EdgeInsets.only(bottom: 72.5, left: 20.0, top: 10),
                        child: TextField(
                          onChanged: (value) {
                            message = value;
                          },
                          onSubmitted: (txt) async {
                            print(txt);
                            this.getInfoML(txt).then((value) {
                              print(value);
                              setState(() {});  
                            });
                          },
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xFFf1e4e8),
                          decoration: InputDecoration(
                              suffixIcon: InkWell(child: Icon(Icons.tag_faces)),
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
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 80,
                          top: 20,
                          left: 5,
                        ),
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: Color(0xFFceb1be)),
                        child: Center(
                            child: Icon(
                          Icons.camera_enhance,
                          color: Colors.white,
                        )),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
