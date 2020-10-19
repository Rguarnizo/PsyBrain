
import 'package:PsyBrain/models/profesional_salud.dart';
import 'package:PsyBrain/utils/login_buttons.dart';
import 'package:flutter/material.dart';




class InfoProfSalud extends StatefulWidget {
  InfoProfSalud({Key key}) : super(key: key);

  @override
  _InfoProfSaludState createState() => _InfoProfSaludState();
}


//! Crea una referencia a la base de datos de firebase.





class _InfoProfSaludState extends State<InfoProfSalud> { 

  String _nombres = '';
  String _apellidos = '';
  String _cedula = '';
  String _fechaNacimiento = '';
  String _telefono = '';
  String _correo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 50,),
          correoField(),
          nombresField(),
          apellidosField(),
          cedulaField(),
          fechaNacimientoField(),
          SizedBox(height: 50,),
          botonAdd(),
        ],
      ),
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

  Widget botonAdd() {
    return MyButton(
        action: () {
          ProfesionalSalud(id: _correo, nombres: _nombres,apellidos: _apellidos,cedula: _cedula,fechaNacimiento: _fechaNacimiento,telefono: _telefono).guardarDatos();

        },
        buttonName: 'Crea tu cuenta',
        gradientColors: [Color(0xFFf1e4e8)],
        textColor: Color(0xFFCEB1BE),
        width: 150,
        withShadow: false,
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
}