import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final bool withShadow;
  final List<Color> gradientColors;
  final String buttonName;
  final Color textColor;
  final AssetImage image;
  final Function action;
  final double HEIGHT = 43.0;

  const MyButton(
      {Key key,
      this.width,
      this.withShadow,
      this.gradientColors,
      this.buttonName,
      this.textColor,
      this.image,
      @required this.action})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: HEIGHT,
      decoration: BoxDecoration(
          color: gradientColors.length == 1 ? gradientColors[0] : null,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: withShadow
              ? [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.black26,
                    offset: Offset(0.0, 0.5),
                  ),
                ]
              : [],
          gradient: gradientColors.length > 1
              ? LinearGradient(
                  colors: gradientColors,
                  begin: FractionalOffset(0.2, 0.0),
                  end: FractionalOffset(1.0, 0.6),
                  stops: [0.0, 0.6],
                  tileMode: TileMode.clamp)
              : null),
      child: InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(9.0),
        child: image != null
            ? Center(
                child: Image(
                  height: 20,
                  image: image,
                ),
              )
            : Center(
                child: Text(buttonName,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'SourceSansPro',
                        color: textColor,
                        fontWeight: FontWeight.w700)),
              ),
      ),
    );
  }
}
