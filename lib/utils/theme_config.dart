import 'package:flutter/material.dart';


//App color
Map<int, Color> color = {
  50: Color.fromRGBO(206, 177, 190, .1),
  100: Color.fromRGBO(206, 177, 190, .2),
  200: Color.fromRGBO(206, 177, 190, .3),
  300: Color.fromRGBO(206, 177, 190, .4),
  400: Color.fromRGBO(206, 177, 190, .5),
  500: Color.fromRGBO(206, 177, 190, .6),
  600: Color.fromRGBO(206, 177, 190, .7),
  700: Color.fromRGBO(206, 177, 190, .8),
  800: Color.fromRGBO(206, 177, 190, .9),
  900: Color.fromRGBO(206, 177, 190, 1),
};



getThemeConfig(){
    return ThemeData(
      primarySwatch: MaterialColor(0xFFceb1be, color),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'SourceSansPro');
}