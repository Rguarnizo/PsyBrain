import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'User/bloc/bloc_user.dart';
import 'User/ui/screens/singin_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return App();
  }

  Widget ConnectionError() {
    return MaterialApp(
        title: 'PsyBrain',
        theme: ThemeData(
            primarySwatch: MaterialColor(0xFFceb1be, color),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'SourceSansPro'),
        home: SignInScreen(),
        debugShowCheckedModeBanner: false);
  }

  Widget App() {
    return BlocProvider(
      bloc: UserBloc(),
      child: MaterialApp(
        title: 'PsyBrain',
        theme: ThemeData(
            primarySwatch: MaterialColor(0xFFceb1be, color),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'SourceSansPro'),
        home: SignInScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget ConnectionLoad() {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
