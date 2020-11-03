import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class UserDeleteInfoPage extends StatefulWidget {
  @override
  _UserDeleteInfoPageState createState() => _UserDeleteInfoPageState();
}

class _UserDeleteInfoPageState extends State<UserDeleteInfoPage> {
  final _formKey = new GlobalKey<FormState>();
  UsuarioBloc usuarioBloc;
  String email;
  String contrasena;

  @override
  Widget build(BuildContext context) {
    usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            _inputsFields(),
            _botonEliminarUsuario(context)

          ],
        ),
      ),
    );
  }


  Widget _emailField() {
    return TextFormField(
      cursorColor: Color(0xFFf1e4e8),
      onChanged: (value) => email = value,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.alternate_email),
          hintText: 'Ingresa aqui tu email',
          contentPadding: EdgeInsets.only(left: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFceb1be), width: 2.0),
            borderRadius: BorderRadius.circular(9.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
    );
  }

  Widget _contrasenaField() {
    return TextFormField(
      cursorColor: Color(0xFFf1e4e8),
      obscureText: true,
      onChanged: (value) => contrasena = value,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.lock),
          hintText: 'Ingresa aqui tu contraseña ',
          contentPadding: EdgeInsets.only(left: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFceb1be), width: 2.0),
            borderRadius: BorderRadius.circular(9.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
    );
  }

  _inputsFields() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _emailField(),
            SizedBox(
              height: 20.0,
            ),
            _contrasenaField(),
          ],
        ),
      ),
    );
  }

  Widget _botonEliminarUsuario(BuildContext context) {
    return MyButton(
        buttonName: 'Eliminar',
        gradientColors: [Color(0xFFceb1be)],
        textColor: Colors.white,
        width: 110,
        withShadow: true,
        action: () async {
          if (_formKey.currentState.validate()) {
            await usuarioBloc.autenticarUsuario(email, contrasena);
            await usuarioBloc.eliminarInformacionUsuario();
          }
        });
  }
}
