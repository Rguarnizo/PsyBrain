

import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUserCard extends StatelessWidget {
  final QueryDocumentSnapshot data;

  SearchUserCard({Key key, this.data}) : super(key: key);

  ProfSaludBloc blocProfSalud;

  @override
  Widget build(BuildContext context) {
    blocProfSalud = BlocProvider.of<ProfSaludBloc>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data.data()['ImageURL']),
      ),
      title: Text(data.data()['Nombres']),
      trailing: Icon(CupertinoIcons.arrow_right),
      onTap: () {
        showDialog(context: context,builder: (dialogContext) {
         return  Container(child: userProfile(dialogContext),height: 200,width: 400,);
        });
      },
    );
  }

  userProfile(context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [              
        Dialog(          
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70,),
                Center(
                  child: Text(data.data()['Nombres'],
                  style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 20.0,
                                
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                ),              
                SizedBox(height: 20,),                            

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Telefono:  ${data.data()['Telefono']}',
                  style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15.0,
                                
                                fontWeight: FontWeight.w600,
                              ),                            
                              ),
                ),
                SizedBox(height: 5,),                            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Correo: ${data.data()['Correo']}',
                  style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15.0,
                                
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                ),
                SizedBox(height: 20,),                                                                                    
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(onPressed: () {
                      blocProfSalud.iniciarChat(data.data()['Uid'],'Quiero Hablar Contigo ☺');
                      Navigator.of(context).pop();                      
                    }, child: Text('Chatear',style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15.0,
                                
                                fontWeight: FontWeight.w600,
                              ),)),
                    FlatButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text('Salir',style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15.0,
                                
                                fontWeight: FontWeight.w600,
                              ),)),
                  ],
                )
               
              ],
            ),
          )
        ),
        Positioned(                   
          top: 220,                                                   
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(data.data()['ImageURL']),
                  ),                
              )        
      ],
    );
  }
}
