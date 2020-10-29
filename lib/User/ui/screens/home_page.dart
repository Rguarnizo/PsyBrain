import 'package:PsyBrain/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc user;
  @override
  Widget build(BuildContext context) {
    user = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: userDrawer(),
    );
  }

  Widget userDrawer() {
    var userInfo = user.getCurrentUser();
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              // Unificar pagina de informacion de usuarios
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ));
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
              userInfo.displayName ?? userInfo.email,
              style: TextStyle(color: Colors.deepOrange[200], fontSize: 20.0),
            ),
          ),
          FlatButton(
              onPressed: () {
                user.signOut();
              },
              child: Icon(Icons.exit_to_app)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }
}
