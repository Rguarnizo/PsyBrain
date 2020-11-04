import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/main.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PsyBrain/Usuario/ui/screens/poll_screen.dart';

class UserRegisterPage extends StatefulWidget {
  UserRegisterPage({Key key}) : super(key: key);

  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  UsuarioBloc usuarioBloc;

  bool esperandoRegistro = false;
  String mensajeResultante = '';

  //TODO: No esta bien utilizar una instancia de Usuario en la clase Bloc para despues asignar en la interfaz. Revisar
  //TODO: No se esta siguiendo una estructura para los datos, fecha de nacimiento y telefono no se registran.
  @override
  Widget build(BuildContext context) {
    usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
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
            contrasenaField(),
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
                esperandoRegistro ? cargandoRegistro() : Container(),
                mensajeResultante.isEmpty ? Container() : mostrarResultado(),
              ],
            ),
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
      onChanged: (value) => usuarioBloc.usuario.correo = value,
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
      onChanged: (value) => usuarioBloc.usuario.nombres = value,
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
      onChanged: (value) => usuarioBloc.usuario.apellidos = value,
    );
  }

  Widget fechaNacimientoField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Fecha Nacimiento',
        helperText: 'Fecha de nacimiento',
        icon: Icon(Icons.calendar_today),
      ),
      onChanged: (value) => usuarioBloc.usuario.fechaNacimiento,
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
      onChanged: (value) => usuarioBloc.usuario.telefono,
      keyboardType: TextInputType.phone,
    );
  }

  Widget botonAdd(BuildContext context) {
    return MyButton(
      action: () async {
        setState(() {
          esperandoRegistro = true;
        });

        if (_formKey.currentState.validate()) {
          mensajeResultante = await usuarioBloc.crearUsuario();
          Navigator.push(context, new MaterialPageRoute(
            builder: (context) => PollScreen()
          ));
          
        }

        setState(() {
          esperandoRegistro = false;
        });
      },
      buttonName: 'Crea tu cuenta',
      gradientColors: [Color(0xFFf1e4e8)],
      textColor: Color(0xFFCEB1BE),
      width: 150,
      withShadow: false,
    );
  }

  Widget contrasenaField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        helperText: 'Constraseña',
        icon: Icon(Icons.lock_outline),
      ),
      onChanged: (value) => usuarioBloc.usuario.contrasena = value,
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

  Widget mostrarResultado() {
    return Center(
      child: Column(
        children: [
          Text(
            '¡$mensajeResultante!',
            style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: color[800],
                fontSize: 20,
                fontWeight: FontWeight.w400
                //fontWeight: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }
}
