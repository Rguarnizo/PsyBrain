import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function action;

  MenuWidget({Key key, this.icon, this.title, this.description, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 20.0, right: 10.0),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: action,
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFceb1be),
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.78),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0),
              ),
              Text(
                description,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SourceSansPro',
                    fontSize: 17.0),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
