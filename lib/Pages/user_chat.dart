import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf1e4e8),
        body: Stack(
          children: [
            Positioned(
                bottom: -65,
                height: 150,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(                      
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(bottom: 72.5, left: 20.0, top:10),
                        child: TextField(
                          cursorColor: Color(0xFFf1e4e8),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.tag_faces),
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
                        width: 49,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
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
