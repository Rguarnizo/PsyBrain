import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserInfoPage extends StatefulWidget {

  UserInfoPage({Key key}) : super(key: key);




  @override
  _UserInfoPageState createState() => _UserInfoPageState();


}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  bool esperandoRegistro = false;
  String mensajeResultante = '';

  UsuarioBloc usuarioBloc;


  @override
  Widget build(BuildContext context) {
    usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
    return FutureBuilder(
        future: usuarioBloc.obtenerInformacion(usuarioBloc.usuario.id),
        builder:(context, snapshot) {

          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key:_formKey,
              child: ListView(
                children: [
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {

                    },
                    child: CircleAvatar(
                      radius: 50,
                      //child: ClipOval(child: Container(child: Image.network(usuarioBloc.currentUser.photoURL),)),
                    ),
                  ),
                  SizedBox(height: 20,),
                  nombresField(),
                  apellidosField(),
                  telefonoField(),
                  fechaNacimientoField(),
                  guardarCambiosButton(context),
                ],
              ),
            ),
          );
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
      initialValue: usuarioBloc.usuario.nombres,
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
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },
      initialValue: usuarioBloc.usuario.apellidos,
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      //initialValue: usuarioBloc.usuario.fechaNacimiento.toString(),
      //onChanged: (value)=> usuarioBloc.usuario.fechaNacimiento=value,
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
      initialValue: usuarioBloc.usuario.telefono,
      onChanged: (value) => usuarioBloc.usuario.telefono = value,
    );
  }

  Widget guardarCambiosButton(BuildContext context) {
    return MyButton(
      action: () async {
        setState(() {

        });

        if (_formKey.currentState.validate()) {
          mensajeResultante =  await usuarioBloc.actualizarInformacionUsuario();
        }
        setState(() {
          esperandoRegistro = false;
        });
      },
      buttonName: 'Guardar Cambios',
      gradientColors: [Color(0xFFf1e4e8)],
      textColor: Color(0xFFCEB1BE),
      width: MediaQuery.of(context).size.width * 0.6,
      withShadow: false,
    );
  }



}
