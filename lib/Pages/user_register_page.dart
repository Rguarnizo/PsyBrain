import 'package:PsyBrain/Pages/home_page.dart';
import 'package:PsyBrain/utils/login_buttons.dart';
import 'package:PsyBrain/utils/theme_config.dart';
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

  String _nombres = '';
  String _apellidos = '';
  String _fechaNacimiento = '';
  String _telefono = '';

  bool _waitRegister = false;
  bool _error = false;
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ingresa tus datos')),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            correoField(),
            passwordField(),
            Container(
              child: Divider(),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            nombresField(),
            apellidosField(),
            fechaNacimientoField(),
            telefonoField(),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                botonAdd(context),
                SizedBox(
                  height: 30,
                ),
                _waitRegister ? cargandoRegistro() : Container(),
              ],
            ),
            _error
                ? errorMSG()
                : Container(), //? Si hubo error lo imprime en pantalla.
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
      validator: (value) {
        if (value.isEmpty) {
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      onChanged: (value) => _nombres = value,
    );
  }

  Widget apellidosField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Apellidos',
        helperText: 'Apellidos',
        icon: Icon(Icons.account_circle),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      onChanged: (value) => _apellidos = value,
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
        icon: Icon(Icons.phone_android),
      ),
      onChanged: (value)=> _telefono = value.toString(),
      keyboardType: TextInputType.phone,
    );

  }

  Widget botonAdd(BuildContext context) {
    return MyButton(
      action: () async {
        //? Valida si el formulario esta bien diligenciado.
        if (_formKey.currentState.validate()) {

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

  Widget cargandoRegistro() {
    return CircularProgressIndicator();
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

}
