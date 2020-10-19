import 'package:PsyBrain/models/profesional_salud.dart';
import 'package:PsyBrain/pages/home_page.dart';
import 'package:PsyBrain/pages/singin_page.dart';
import 'package:PsyBrain/routes/routes.dart';
import 'package:PsyBrain/utils/login_buttons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _nombres = '';

  String _apellidos = '';

  String _cedula = '';

  String _fechaNacimiento = '';

  String _telefono = '';

  String _correo = '';

  String _password = '';

  bool _waitRegister = false;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(        
        children: [
          SizedBox(height: 50,),
          correoField(),
          passwordField(),
          nombresField(),
          apellidosField(),
          cedulaField(),
          fechaNacimientoField(),
          SizedBox(height: 50,),
          Column(
            children: [
              botonAdd(context),
              _waitRegister ? cargandoRegistro():Divider(),
            ],
          ),
            
          
        ],
      ),
    );
  }

   Widget correoField() {
     return TextField(
      decoration: InputDecoration(
        hintText: 'Correo',
        helperText: 'Correo Electronico',
        icon: Icon(Icons.mail),        
      ),      
      onChanged: (value) {
        _correo = value;
      },
    );

  }

  Widget nombresField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Nombres',
        helperText: 'Nombres',
        icon: Icon(Icons.accessibility),        
      ),
      onChanged: (value) => _nombres = value,
    );

  }

  Widget apellidosField() {
      return TextField(
      decoration: InputDecoration(
        hintText: 'Apellidos',
        helperText: 'Apellidos',
        icon: Icon(Icons.account_circle),        
      ),      
      onChanged: (value) => _apellidos = value,
    );
  }

  Widget cedulaField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cedula',
        helperText: 'Cedula',
        icon: Icon(Icons.credit_card),        
      ),      
      onChanged: (value) => _cedula = value,
    );
  }

  Widget fechaNacimientoField(){

    return TextField(
      decoration: InputDecoration(
        hintText: 'Fecha Nacimiento',
        helperText: 'Fecha de nacimiento',
        icon: Icon(Icons.calendar_today),        
      ),      
      onChanged: (value) {
        _fechaNacimiento = value;
      },
    );
  }

  Widget botonAdd(BuildContext context) {
    return MyButton(
        action: () async {          
          
          setState(() {
            _waitRegister = true;  
          });
         final result =  await ProfesionalSalud(
            nombres: _nombres,
            apellidos: _apellidos,
            cedula: _cedula,
            fechaNacimiento: _fechaNacimiento,
            id: _correo,
            password: _password,
            telefono: _telefono).guardarDatos();
            setState(() {
              _waitRegister = false;
            });
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(user: result)), (route) => false);
          
        },
        buttonName: 'Crea tu cuenta',
        gradientColors: [Color(0xFFf1e4e8)],
        textColor: Color(0xFFCEB1BE),
        width: 150,
        withShadow: false,
    );
  }

  Widget passwordField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Contraseña',
        helperText: 'Constraseña',
        icon: Icon(Icons.calendar_today),        
      ),      
      onChanged: (value) {
        _password = value;
      },
    );
  }

  Widget cargandoRegistro() {
    return CircularProgressIndicator(
      
    );
  }
}