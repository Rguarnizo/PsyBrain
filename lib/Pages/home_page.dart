import 'package:PsyBrain/Pages/info_page_profsalud.dart';
import 'package:PsyBrain/pages/singin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  final User user;
  const HomePage({@required this.user,Key key}) : super(key: key);
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoProfSalud(user: widget.user),));
              },
                child: CircleAvatar(
                radius: 50,              
                child: ClipOval(child: Container(child: Image.network(widget.user.photoURL),)),
              ),
            ),
            SizedBox(height: 30.0,),
            Center(
              child: Text(widget.user.displayName?? 'No name',
              style: TextStyle(
                color: Colors.deepOrange[200],
                fontSize: 20.0),
              ),
            ),
            FlatButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => false);
            }, child: Icon(Icons.exit_to_app)),            
          ],
        ),
    );
  }
}