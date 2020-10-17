
import 'package:PsyBrain/Pages/singin_screen.dart';
import 'package:PsyBrain/routes/routes.dart';
import 'package:PsyBrain/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(PsyBrain());
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
