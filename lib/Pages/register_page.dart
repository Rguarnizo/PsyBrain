import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/main.dart';
import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UsuarioBloc usuarioBloc;
  ProfSaludBloc profSaludBloc;

  final _formKey = GlobalKey<FormState>();

  
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  TextEditingController nombres = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController fechaNacimiento = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController licencia = TextEditingController();

    bool esProfSalud = false;
    bool esperandoRegistro = false;
    String mensajeResultante = '';

  @override
  Widget build(BuildContext context) {
      
    usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
    profSaludBloc = BlocProvider.of<ProfSaludBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Ingresa tus datos',style: TextStyle(color: Colors.white),),iconTheme: IconThemeData(color: Colors.white),),
      body: Form(
        key: _formKey,
        child: ListView(                  
          children: [
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
            switchProfSalud(),
            esProfSalud ? licenciaField():Container(),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                botonAdd(context),
                SizedBox(
                  height: 30,
                ),
                esperandoRegistro? cargandoRegistro() : Container(),
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      controller: correo,
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      controller: contrasena,
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
      controller: nombres,
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
      controller: apellidos,
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
      controller: fechaNacimiento,
    );
  }

  Widget telefonoField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Teléfono',
        helperText: 'Teléfono',
        icon: Icon(Icons.phone_android),
      ),
      keyboardType: TextInputType.phone,
      controller: telefono,
    );
  }

  Widget switchProfSalud() {
    return Container(      
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: color[600],
      ),
      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '¿Eres profesional de la salud?',
                style: TextStyle(                    
                    color: Colors.white,                    
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                    //fontWeight: FontStyle.italic,
                    ),
            ),
            Switch(
              value: esProfSalud, 
              onChanged: (value) {
                setState(() {
                  esProfSalud = value;
                });
              },
            ),
          ],
        ),
    );
  }

  licenciaField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Licencia',
        helperText:
            'Licencia profesional ',
        icon: Icon(Icons.card_membership),
      ),
      validator: (value) {
        if(value.isEmpty && esProfSalud){
          return 'Licencia Obligatoria';
        }
        return null;
      },
      controller: licencia,
    );
  }

  Widget botonAdd(BuildContext context) {
    return MyButton(
      action: () async {
          if(_formKey.currentState.validate()){
            if(esProfSalud){
              profSaludBloc.setProfSaludInfo(toJsonProfSalud());
              mensajeResultante = await profSaludBloc.crearProfSalud();
            }else{
              usuarioBloc.setUsuarioInfo(toJsonUsuario());
              mensajeResultante = await usuarioBloc.crearUsuario();
            }
          }
      },
      buttonName: 'Crea tu cuenta',
      gradientColors: [color[800]],
      textColor: Colors.white,
      width: 150,
      withShadow: false,
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


  Map<String,dynamic> toJsonProfSalud(){
        return {
          'Nombres'        : nombres.text,
          'Apellidos'      : apellidos.text,
          'Correo'         : correo.text,
          'FechaNacimiento': fechaNacimiento.text,
          'Licencia'       : licencia.text,          
          'Telefono'       : telefono.text,
          'Contraseña'     : contrasena.text,
        };        
  }

  Map<String,dynamic> toJsonUsuario(){
        return {
          'Nombres'        : nombres.text,
          'Apellidos'      : apellidos.text,
          'Correo'         : correo.text,
          'FechaNacimiento': fechaNacimiento.text,          
          'Telefono'       : telefono.text,
          'Contraseña'     : contrasena.text,
        };        
  }
  
  @override
  void dispose() {
    usuarioBloc.dispose();
    profSaludBloc.close();
    super.dispose();
  }


}
