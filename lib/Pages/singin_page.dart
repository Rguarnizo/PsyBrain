import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {


  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  UsuarioBloc user;

  String emailInput;
  String passwordInput;

  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    user = BlocProvider.of<UsuarioBloc>(context);

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            _titulo(),
            _subtitle(),
            _image(),
            _inputsFields(),
            _buttons(),
            //botonCrearCuentaUsuario(context),
          ],
        ),
      ),
    );
  }

  Widget _titulo() {
    return Center(
      child: Text(
        '¡Bienvenido de nuevo!',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'SourceSansPro',
            fontSize: 28.2,
            fontWeight: FontWeight.w400
            //fontWeight: FontStyle.italic,
            ),
      ),
    );
  }

  Widget _subtitle() {
    return Center(
      child: Text(
        'Ingresa para continuar',
        style: TextStyle(
            color: Colors.grey,
            //fontWeight: FontWeight.w700,
            fontFamily: 'SourceSansPro',
            fontSize: 18.2,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _image() {
    return Container(
        margin:
            EdgeInsets.only(left: 30.0, right: 30.0, top: 60.5, bottom: 30.5),
        child: Image.asset('assets/imgs/login_img.png'));
  }

  Widget _emailInput() {
    return TextFormField(
      cursorColor: Color(0xFFf1e4e8),
      onChanged: (value) => emailInput = value,
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

  Widget _passwordInput() {
    return TextFormField(
      cursorColor: Color(0xFFf1e4e8),
      obscureText: true,
      onChanged: (value) => passwordInput = value,
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

  Widget botonEntrar(BuildContext context) {
    return MyButton(
        buttonName: 'Entrar',
        gradientColors: [Color(0xFFceb1be)],
        textColor: Colors.white,
        width: 110,
        withShadow: true,
        action: () async {
          if (_formKey.currentState.validate()) {
            user.signInWithEmailAndPassword(emailInput, passwordInput, context);
          }
        });
  }

  Widget botonGoogle(BuildContext context) {
    return MyButton(
      gradientColors: [Color(0xFFceb1be)],
      withShadow: false,
      width: 50,
      image: AssetImage('assets/imgs/google_icon.png'),
      action: () {
        user.signInGoogle();
      },
    );
  }

  Widget botonCrearCuenta(BuildContext context) {
    return MyButton(
      action: () {
        Navigator.of(context).pushNamed('RegisterPage');
      },
      buttonName: 'Crea tu cuenta',
      gradientColors: [Color(0xFFf1e4e8)],
      textColor: Color(0xFFCEB1BE),
      width: 150,
      withShadow: false,
    );
  }

  Widget botonCrearCuentaUsuario(BuildContext context) {
    return MyButton(
      action: () {
        Navigator.of(context).pushNamed('RegisterPage');
      },
      buttonName: 'Registrate',
      gradientColors: [Color(0xFFf1e4e8)],
      textColor: Color(0xFFCEB1BE),
      width: MediaQuery.of(context).size.width * 0.8,
      withShadow: false,
    );
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }

  _inputsFields() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _emailInput(),
            SizedBox(
              height: 20.0,
            ),
            _passwordInput(),
          ],
        ),
      ),
    );
  }

  _buttons() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          botonEntrar(context),
          botonGoogle(context),
          botonCrearCuenta(context),
        ],
      ),
    );
  }
}

