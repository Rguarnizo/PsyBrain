

import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InfoProfSalud extends StatefulWidget {
  InfoProfSalud({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfoProfSaludState();

 
}

class _InfoProfSaludState extends State<InfoProfSalud> {
  
  ProfSaludBloc profSaludBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    profSaludBloc = BlocProvider.of<ProfSaludBloc>(context);

    return FutureBuilder(
       future: profSaludBloc.obtenerInformacion(),
       builder:(context, snapshot) {
         if(snapshot.hasData){          
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _formKey,
              child: ListView(
              children: [
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: CircleAvatar(
                      radius: 50,              
                      //child: ClipOval(child: Container(child: Image.network(profSaludBloc.currentUser.photoURL),)),
                    ),
                ),
                  SizedBox(height: 20,),
                  nombresField(),
                  apellidosField(),
                  cedulaField(),            
                  telefonoField(),
                  licenciaField(),
                  botonActualizar(),
              ],
          ),
        ),
      );
      }else{
        return Scaffold(
          appBar: AppBar(),
          body: Center(            
            child: CircularProgressIndicator(),
          ),
        );
      }
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
      initialValue: profSaludBloc.profSalud.nombres,
      onChanged: (value) => profSaludBloc.profSalud.nombres = value,
      
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
      initialValue: profSaludBloc.profSalud.apellidos,
      onChanged: (value) => profSaludBloc.profSalud.apellidos = value,

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
      initialValue: profSaludBloc.profSalud.cedula,
      onChanged: (value) => profSaludBloc.profSalud.cedula = value,
    );    
  }

   Widget licenciaField() {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Licencia',
          helperText: 'Licencia profesional. Si aún no la tienes deja este campo vacio.',
          icon: Icon(Icons.card_membership),        
        ),      
        validator: (value) {
          if(value.isEmpty){
            return 'Campo obligatorio';
          }
          return null;
        },
      initialValue: profSaludBloc.profSalud.licencia,
      onChanged: (value) => profSaludBloc.profSalud.licencia = value,
        
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
      initialValue: profSaludBloc.profSalud.telefono,
      onChanged: (value) => profSaludBloc.profSalud.telefono = value,
      );    
  }

  Widget botonActualizar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: MyButton(
          buttonName: 'Guardar Cambios',
          gradientColors: [Color(0xFFceb1be)],
          textColor: Colors.white,
          width: 110,
          withShadow: true,
          action: () async {
             if(_formKey.currentState.validate()){
               await profSaludBloc.actualizarInformacion();
             }
          }),
    );
  }
}
