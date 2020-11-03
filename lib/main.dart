import 'package:PsyBrain/ProfSalud/UI/home_page_profSalud.dart';
import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/screens/home_page.dart';
import 'package:PsyBrain/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class PsyBrain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UsuarioBloc(),),
        BlocProvider(create: (context) => ProfSaludBloc(),)
      ],
      child: MateApp(),
    );
  }

 
}

class MateApp extends StatelessWidget {
  const MateApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UsuarioBloc userBloc = BlocProvider.of<UsuarioBloc>(context);
    return MaterialApp(
      title: 'PsyBrain',
      routes: getApplicationRoutes(),
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFFceb1be, color),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'SourceSansPro'),
      home: StreamBuilder(
        stream: userBloc.authStatus,
        builder:  (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
            return SignInScreen();
          } else {
            //eturn HomePageProfSalud();
            return HomePage();
          }
        }, 
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


  