import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  String _correo = '';
  String _password = '';

  String _id;
  String _nombres;
  String _apellidos;
  String _fechaNacimiento;
  String _telefono;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MisDatos'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            correoField(),
            passwordField(),
            fechaNacimientoField(),
            telefonoField(),
          ],
        ),
      ),
    );
  }

  Widget correoField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: '',
        helperText: 'Correo Electronico',
        icon: Icon(Icons.mail),
      ),
      onChanged: (value) {
        _correo = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
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
      onChanged: (value) {
        _password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
    );
  }

  Widget fechaNacimientoField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Fecha Nacimiento',
        helperText: 'Fecha de nacimiento',
        icon: Icon(Icons.calendar_today),
      ),
      onChanged: (value) {
        _fechaNacimiento = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
    );
  }

  Widget telefonoField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Teléfono',
        helperText: 'Teléfono',
        icon: Icon(Icons.calendar_today),
      ),
      onChanged: (value) {
        _telefono = value;
      },
    );
  }
}
