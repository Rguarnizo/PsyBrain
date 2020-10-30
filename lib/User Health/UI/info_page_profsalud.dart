/*
import 'package:PsyBrain/models/User/bloc_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InfoProfSalud extends StatefulWidget {
  InfoProfSalud({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfoProfSaludState();

 
}

class _InfoProfSaludState extends State<InfoProfSalud> {
  
  UserBloc user;

  @override
  Widget build(BuildContext context) {

    user = BlocProvider.of<UserBloc>(context);

    return FutureBuilder(
       future: user.getInfo(),
       builder:(context, snapshot) {

          return Scaffold(
            appBar: AppBar(),
            body: ListView(
            children: [
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  
                },
                child: CircleAvatar(
                    radius: 50,              
                    child: ClipOval(child: Container(child: Image.network(user.currentUser.photoURL),)),
                  ),
              ),
                SizedBox(height: 20,),
                nombresField(),
                apellidosField(),
                cedulaField(),            
                telefonoField(),
                licenciaField(),

            ],
        ),
          );
       }
       
    );

  }

 Widget nombresField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Nombres',
        helperText: 'Nombres',
        icon: Icon(Icons.accessibility),        
      ),
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },
      initialValue: user.userData['Nombres'],
      onChanged: (value) => user.userData['Nombres'] = value,
      
    );

  }

  Widget apellidosField() {
      return TextFormField(
      decoration: InputDecoration(
        hintText: 'Apellidos',
        helperText: 'Apellidos',
        icon: Icon(Icons.account_circle),        
      ),
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },          
      initialValue: user.userData['Apellidos'],
      onChanged: (value) => user.userData['Apellidos'] = value,

    );
  }

  Widget cedulaField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Cedula',
        helperText: 'Cedula',
        icon: Icon(Icons.credit_card),        
      ),      
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },      
      keyboardType: TextInputType.number,
      initialValue: user.userData['Cedula'],
      onChanged: (value) => user.userData['Cedula'] = value,
    );    
  }

   Widget licenciaField() {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Licencia',
          helperText: 'Licencia profesional. Si aún no la tienes deja este campo vacio.',
          icon: Icon(Icons.card_membership),        
        ),      
      initialValue: user.userData['Licencia'],
      onChanged: (value) => user.userData['Licencia'] = value,
        
      );    
  }

  Widget telefonoField() {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Telefono',
          helperText: 'Telefono',
          icon: Icon(Icons.phone),        
        ),      
        keyboardType: TextInputType.number,
              initialValue: user.userData['Telefono'],
      onChanged: (value) => user.userData['Telefono'] = value,
      );    
  }
}
*/