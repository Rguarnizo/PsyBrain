import 'package:PsyBrain/User%20Health/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/utils/login_buttons.dart';
import 'package:PsyBrain/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class RegisterPageProfSalud extends StatefulWidget {
  RegisterPageProfSalud({Key key}) : super(key: key);

  @override
  _RegisterPageStateProfSalud createState() => _RegisterPageStateProfSalud();
}

class _RegisterPageStateProfSalud extends State<RegisterPageProfSalud> {

  final _formKey = GlobalKey<FormState>();

  ProfSaludBloc profSaludBloc;
  


  bool _waitRegister = false;
  bool _error = false;
  String errorMessage;

  @override
  Widget build(BuildContext context) {
   
    profSaludBloc = BlocProvider.of<ProfSaludBloc>(context);

    return Scaffold(
      body: Form(
          key: _formKey,
          child: ListView(        
          children: [
            SizedBox(height: 50,),
            correoField(),
            passwordField(),
             Container(child: Divider(), margin: EdgeInsets.symmetric(vertical: 10),),
            nombresField(),
            apellidosField(),
            cedulaField(),
            fechaNacimientoField(),
            licenciaField(),
            SizedBox(height: 50,),
            Column(
              children: [
                botonAdd(context),
                SizedBox(height: 30,),
                _waitRegister ? cargandoRegistro():Container(),              
              ],
            ),         
            _error ? errorMSG():Container(),      //? Si hubo error lo imprime en pantalla.
          ],
        ),
      ),
    );
  }

   Widget correoField() {
     return TextFormField(
      decoration: InputDecoration(
        hintText: 'Correo',
        helperText: 'Correo Electronico',
        icon: Icon(Icons.mail),        
      ),      
      onChanged: (value) => profSaludBloc.profSalud.correo = value,
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },   
      keyboardType: TextInputType.emailAddress,
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
      onChanged: (value) => profSaludBloc.profSalud.cedula = value,
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },
      keyboardType: TextInputType.number,
    );
  }

  Widget fechaNacimientoField(){

    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Fecha Nacimiento',
        helperText: 'Fecha de nacimiento',
        icon: Icon(Icons.calendar_today),                
      ),
      onChanged: (value) => profSaludBloc.profSalud.fechaNacimiento,
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },   
    );
  }

  Widget botonAdd(BuildContext context) {
    return MyButton(
        action: () async {          
          if(_formKey.currentState.validate()){
            profSaludBloc.crearProfSalud();      
          }           
        },
        buttonName: 'Crea tu cuenta',
        gradientColors: [Color(0xFFf1e4e8)],
        textColor: Color(0xFFCEB1BE),
        width: 150,
        withShadow: false,
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        helperText: 'Constraseña',
        icon: Icon(Icons.lock_outline),        
      ),      
      onChanged: (value) => profSaludBloc.profSalud.contrasena = value,
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },   
    );
  }

  Widget cargandoRegistro() {
    return CircularProgressIndicator(
      
    );
  }

  Widget errorMSG() {
    return Center(
            child: Column(
              children: [
                Text(
                '¡$errorMessage!',
                 style: TextStyle(
                color: color[900],
                fontFamily: 'SourceSansPro',
                fontSize: 20,
                fontWeight: FontWeight.w400
                //fontWeight: FontStyle.italic,
                ),
               ),
              Text(
                'Verifica que todo este correcto',
                 style: TextStyle(
                color: color[900],
                fontFamily: 'SourceSansPro',
                fontSize: 15,
                fontWeight: FontWeight.w400
                //fontWeight: FontStyle.italic,
                ),
              ),
              ],
            ),
          );
  }

  licenciaField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Licencia',
        helperText: 'Licencia profesional. Si aún no la tienes deja este campo vacio.',
        icon: Icon(Icons.card_membership),        
      ),      
      onChanged: (value) => profSaludBloc.profSalud.nombres = value,
      
    );
  }

  
}