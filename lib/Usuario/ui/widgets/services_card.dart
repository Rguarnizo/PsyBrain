import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 18.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Color(0xFFf1e4e8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 14.0, right: 20.0),
              child: InkWell(
                  onTap: () {
                    //TODO: Requerimiento de preguntas frecuentes
                  },
                  child: Row(
                    children: [
                      Text(
                        'Preguntas frecuentes',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Icon(
                        CupertinoIcons.chevron_forward,
                        color: Colors.grey,
                        size: 20.0,
                      )
                    ],
                  ))),
          Container(
            margin: EdgeInsets.only(left: 18.0, right: 18.0),
            child: Divider(
              thickness: 1.4,
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
