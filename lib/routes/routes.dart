
import 'package:PsyBrain/Pages/singin_page.dart';
import 'package:PsyBrain/ProfSalud/UI/screens/home_page_profSalud.dart';
import 'package:PsyBrain/ProfSalud/UI/screens/register_page_profSalud.dart';
import 'package:PsyBrain/Usuario/ui/screens/user_chat.dart';
import 'package:PsyBrain/Usuario/ui/screens/user_register_page.dart';
import 'package:PsyBrain/Usuario/ui/screens/home_page.dart';
import 'package:flutter/material.dart';




Map<String,WidgetBuilder> getApplicationRoutes(){


final rutas = <String,WidgetBuilder>{
        'SingIn'                : (BuildContext context) => SignInScreen(),
        'UserChat'              : (BuildContext context) => UserChat(),    
        'RegisterPageProfSalud' : (BuildContext context) => RegisterPageProfSalud(),
        'UserRegisterPage'      : (BuildContext context) => UserRegisterPage(),
        'RegisterPage'          : (BuildContext context) => RegisterPageProfSalud(),
        'HomePageProfSalud'     : (BuildContext context) => HomePageProfSalud(),
        'HomePageUser'          : (BuildContext context) => HomePageUser(),
       // 'UserRegisterPageGoogle': (BuildContext context) => UserRegisterPageGoogle(),
      };
      
  return rutas;
}