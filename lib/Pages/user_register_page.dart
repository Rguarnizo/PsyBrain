import 'package:flutter/material.dart';

class UserRegisterPage extends StatefulWidget {

  UserRegisterPage({Key key}) : super(key: key);


  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {

  final _formKey = GlobalKey<FormState>();

  String _correo = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('appbarTitle'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              correoField(),
              passwordField(),
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
      onChanged: (value) {
        _correo = value;
      },
      validator: (value){
        if(value.isEmpty){
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
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },
    );
  }

}
