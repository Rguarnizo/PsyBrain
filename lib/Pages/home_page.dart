import 'package:PsyBrain/Pages/info_page_profsalud.dart';
import 'package:PsyBrain/models/User/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
    return Drawer(
        child: Column(          
          children: [            
            SizedBox(height: 40,),
            GestureDetector(
              onTap: () {                
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoProfSalud(),));
              },
                child: CircleAvatar(
                radius: 50,              
                child: ClipOval(child: Container(child: Image.network(user.currentUser.photoURL),)),
              ),
            ),
            SizedBox(height: 30.0,),
            Center(
              child: Text(user.currentUser.displayName?? 'No name',
              style: TextStyle(
                color: Colors.deepOrange[200],
                fontSize: 20.0),
              ),
            ),
            FlatButton(onPressed: (){
              user.signOut();                        
            }, child: Icon(Icons.exit_to_app)),            
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