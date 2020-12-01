import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WordCard extends StatelessWidget {
  final String text;
  final String label;

  WordCard({Key key, this.text, this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 5, bottom: 5, left: 5),
      child: Container(
        height: 30.0,
        //width: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 3.0,
                  spreadRadius: 1.2,
                  offset: Offset(0, 0))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
              label == "positive"
                  ? Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SvgPicture.network(
                        "https://www.flaticon.es/svg/static/icons/svg/1533/1533908.svg",
                        height: 15.0,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SvgPicture.network(
                        "https://www.flaticon.es/svg/static/icons/svg/1533/1533914.svg",
                        height: 15.0,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
