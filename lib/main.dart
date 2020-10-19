
import 'package:PsyBrain/routes/routes.dart';

import 'package:PsyBrain/utils/theme_config.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'Pages/singin_page.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  )); 
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(PsyBrain());
  Firebase.initializeApp();
}

class PsyBrain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
        title: 'PsyBrain',
        routes: getApplicationRoutes(),
        theme: getThemeConfig(),
        home: SignInScreen(),
        debugShowCheckedModeBanner: false,
      );
  }
      
}