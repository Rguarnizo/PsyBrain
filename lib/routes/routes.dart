
import 'package:PsyBrain/Pages/singin_page.dart';
import 'package:PsyBrain/User%20Health/UI/register_page_profSalud.dart';
import 'package:PsyBrain/User/ui/user_chat.dart';
import 'package:PsyBrain/User/ui/user_register_page.dart';
import 'package:flutter/material.dart';




Map<String,WidgetBuilder> getApplicationRoutes(){


final rutas = <String,WidgetBuilder>{
        'SingIn'       : (BuildContext context) => SignInScreen(),
        'UserChat'     : (BuildContext context) => UserChat(),    
        'RegisterPageProfSalud' : (BuildContext context) => RegisterPageProfSalud(),
        'UserRegisterPage':(BuildContext context) => UserRegisterPage(),
      };
      
  return rutas;
}