


import 'package:PsyBrain/models/User/bloc_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

getProviders(){
  return [
    BlocProvider(create:(_) => UserBloc(),),
  ];
}