import 'package:PsyBrain/ProfSalud/UI/screens/home_page_profSalud.dart';
import 'package:PsyBrain/UI/screens/bot_chat.dart';
import 'package:PsyBrain/UI/screens/register_page.dart';
import 'package:PsyBrain/Usuario/ui/screens/home_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  final rutas = <String, WidgetBuilder>{
    'BotChat': (BuildContext context) => BotChat(),
    'RegisterPage': (BuildContext context) => RegisterPage(),
    'HomePageProfSalud': (BuildContext context) => HomePageProfSalud(),
    'HomePageUser': (BuildContext context) => HomePageUser(),
    // 'UserRegisterPageGoogle': (BuildContext context) => UserRegisterPageGoogle(),
  };

  return rutas;
}
