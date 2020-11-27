import 'package:PsyBrain/ProfSalud/UI/screens/home_page_profSalud.dart';
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main
import 'package:PsyBrain/ProfSalud/UI/screens/info_page_profsalud.dart';
import 'package:PsyBrain/UI/screens/register_page.dart';
import 'package:PsyBrain/Usuario/ui/screens/poll_screen.dart';
import 'package:PsyBrain/Usuario/ui/screens/user_chat.dart';
========================================================================
import 'package:PsyBrain/UI/screens/bot_chat.dart';
import 'package:PsyBrain/UI/screens/register_page.dart';
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> chat_task121
import 'package:PsyBrain/Usuario/ui/screens/home_page.dart';
import 'package:flutter/material.dart';

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main




Map<String,WidgetBuilder> getApplicationRoutes(){


final rutas = <String,WidgetBuilder>{
        'UserChat'              : (BuildContext context) => UserChat(),    
        'RegisterPage'          : (BuildContext context) => RegisterPage(),
        'HomePageProfSalud'     : (BuildContext context) => HomePageProfSalud(),
        'InfoProfSalud'         : (BuildContext context) => InfoProfSalud(),
        'HomePageUser'          : (BuildContext context) => HomePageUser(),
========================================================================
Map<String, WidgetBuilder> getApplicationRoutes() {
  final rutas = <String, WidgetBuilder>{
    'BotChat': (BuildContext context) => BotChat(),
    'RegisterPage': (BuildContext context) => RegisterPage(),
    'HomePageProfSalud': (BuildContext context) => HomePageProfSalud(),
    'HomePageUser': (BuildContext context) => HomePageUser(),
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> chat_task121
    // 'UserRegisterPageGoogle': (BuildContext context) => UserRegisterPageGoogle(),
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< main
       'UsuarioPoll'            : (BuildContext context) => PollScreen(),
      };
========================================================================
  };
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> chat_task121

  return rutas;
}
