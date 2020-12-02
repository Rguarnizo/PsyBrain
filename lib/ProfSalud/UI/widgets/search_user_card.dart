import 'package:PsyBrain/ProfSalud/UI/widgets/user_profile.dart';
import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/Usuario/ui/screens/user_chat.dart';
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
        showDialog(
            context: context,
            builder: (dialogContext) {
              return Container(
                child: UserProfile(data: data.data(),),
                height: 200,
                width: 400,
              );
            });
      },
    );
  }


}


