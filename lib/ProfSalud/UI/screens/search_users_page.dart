import 'package:PsyBrain/ProfSalud/UI/widgets/search_user_card.dart';
import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/Usuario/ui/widgets/user_card_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';

class SearchUserPage extends StatefulWidget {
  SearchUserPage({Key key}) : super(key: key);

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {

  ProfSaludBloc userHealthBloc;
  String query = '';
  bool shereFriends = true;

  @override
  Widget build(BuildContext context) {
    userHealthBloc = BlocProvider.of<ProfSaludBloc>(context);    

    return CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    shereFriends = !shereFriends;
                                  });
                                },
                                child: Text(shereFriends?'Amigos':'Medicos',style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 20.0,             
                                fontWeight: FontWeight.bold,               
                            ),),
                              ),
                            ],
                          ),
                          middle: TextField(
                            decoration: InputDecoration(
                              hintText: 'Ingrese el nombre del usuario',
                            ),
                            onChanged: (value) {
                              setState(() {
                                query = value;                                
                              });
                            },
                          ),
                          trailing: Icon(CupertinoIcons.search)),

                      child: StreamBuilder(
                          stream: shereFriends? userHealthBloc.getListUsers(query):userHealthBloc.getListHealth(query),
                          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {                                                       
                            if(snapshot.hasData){                              
                              return ListView.builder(
                                
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {                                                                    
                                  return SearchUserCard(data: snapshot.data.docs[index],);
                                },
                                );
                            }else {
                              return Container();
                            }                          
                        },
                      ),
                  );
  }
}