import 'package:PsyBrain/Pages/info_profsalud.dart';
import 'package:PsyBrain/Pages/singin_page.dart';
import 'package:PsyBrain/Pages/user_chat.dart';
import 'package:PsyBrain/pages/register_page.dart';
import 'package:flutter/material.dart';




Map<String,WidgetBuilder> getApplicationRoutes(){


final rutas = <String,WidgetBuilder>{
        'SingIn'       : (BuildContext context) => SignInScreen(),
        'UserChat'     : (BuildContext context) => UserChat(),
        'InfoProfSalud': (BuildContext context) => InfoProfSalud(),
        'RegisterPage' : (BuildContext context) => RegisterPage(),
      };
      
  return rutas;
}