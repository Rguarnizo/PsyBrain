import 'package:PsyBrain/Pages/register_page_profSalud.dart';
import 'package:PsyBrain/Pages/singin_page.dart';
import 'package:PsyBrain/Pages/user_chat.dart';
import 'package:flutter/material.dart';




Map<String,WidgetBuilder> getApplicationRoutes(){


final rutas = <String,WidgetBuilder>{
        'SingIn'       : (BuildContext context) => SignInScreen(),
        'UserChat'     : (BuildContext context) => UserChat(),    
        'RegisterPageProfSalud' : (BuildContext context) => RegisterPageProfSalud()
      };
      
  return rutas;
}