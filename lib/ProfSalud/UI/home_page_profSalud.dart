import 'package:PsyBrain/ProfSalud/UI/info_page_profsalud.dart';
import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageProfSalud extends StatefulWidget {
  const HomePageProfSalud({Key key}) : super(key: key);

  @override
  _HomePageProfSaludState createState() => _HomePageProfSaludState();
}

class _HomePageProfSaludState extends State<HomePageProfSalud> {
  ProfSaludBloc profSaludBloc;
  @override
  Widget build(BuildContext context) {
    profSaludBloc = BlocProvider.of<ProfSaludBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: userDrawer(),
    );
  }

  Widget userDrawer() {
    var userInfo = profSaludBloc.currentUser;
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              // Unificar pagina de informacion de usuarios
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoProfSalud()));
            },
            child: CircleAvatar(
              radius: 50,
              child: ClipOval(
                  child: Container(
                     //Poner una imagen por defecto para los usuarios que no entran por Google. 
                      child: userInfo.photoURL != null
                          ? Image.network(userInfo.photoURL)
                          : null)),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              userInfo.email,
              style: TextStyle(color: Colors.deepOrange[200], fontSize: 20.0),
            ),
          ),
          FlatButton(
              onPressed: () {
                profSaludBloc.signOut();
              },
              child: Icon(Icons.exit_to_app)),
          FlatButton(
              onPressed: () {
                profSaludBloc.eliminarProfSalud();
              },
              child: Icon(Icons.remove_circle_outline)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}