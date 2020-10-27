
import 'package:PsyBrain/Pages/home_page.dart';
import 'package:PsyBrain/models/User/bloc_user.dart';
import 'package:PsyBrain/models/providers.dart';
import 'package:PsyBrain/routes/routes.dart';

import 'package:PsyBrain/utils/theme_config.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Pages/singin_page.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  )); 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PsyBrain());
  
  
}

class PsyBrain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
        return MultiBlocProvider(
          providers: getProviders(),
          child: MaterialApp(
          title: 'PsyBrain',
          routes: getApplicationRoutes(),
          theme: getThemeConfig(),
          home:  UserLogged(),
          debugShowCheckedModeBanner: false,
      ),
        );
  }
      
}

class UserLogged extends StatelessWidget {
  const UserLogged({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserBloc user = BlocProvider.of<UserBloc>(context);
    
    return StreamBuilder(
      stream: user.authStatus,
      builder: (context, snapshot) {
      if (!snapshot.hasData || snapshot.hasError) {
            user.dispose();
            return SignInScreen();
      } else {
            user.dispose();
            return HomePage();
        }
      },
    );
  }
}