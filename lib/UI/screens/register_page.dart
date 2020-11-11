import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/UI/widgets/datetime_picker_selector.dart';
import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/ui/screens/poll_screen.dart';
import 'package:PsyBrain/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  DateTime fechaNacimiento = DateTime.now();
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
          body: CupertinoPageScaffold(    
        navigationBar: CupertinoNavigationBar(middle: Text('Registrate'),),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(          

              children: [
                correoField(),
                Container(height: 20,),
                contrasenaField(),
                Container(
                  child: Divider(),
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                nombresField(),
                Container(height: 20,),
                apellidosField(),
                Container(height: 20,),
                fechaNacimientoField(),
                Container(height: 20,),
                telefonoField(),
                Container(height: 20,),
                switchProfSalud(),
                Container(height: 10,),
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
        ),
      ),
    );
  }

  Widget correoField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Correo',    
        suffixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))
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
        suffixIcon: Icon(Icons.lock_outline),
        contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))
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
        contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9)),
        hintText: 'Nombres',    
        suffixIcon: Icon(Icons.accessibility),
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
        suffixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))
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
    return InkWell(
                onTap: () async {
                  await Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                          opacity: animation,
                          child: DateTimePickerSelector(
                            setBornDate: setBornDate,
                          ));
                    },
                  ));
                  setState(() {});
                },
                child: TextFormField(
                  // onSaved: (value) => bornDate = ,
                  cursorColor: Color(0xFFf1e4e8),
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.calendar),
                      hintText: DateFormat('yyyy/MM/dd').format(fechaNacimiento),
                      contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                ),
              );
  }

  Widget telefonoField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Teléfono',
        suffixIcon: Icon(Icons.phone_android),
        contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))
      ),
      keyboardType: TextInputType.phone,
      controller: telefono,
    );
  }

  Widget switchProfSalud() {
    return ListTile(
      title: Text('¿Eres usuario de salud?'),
      trailing: CupertinoSwitch(
              value: esProfSalud, 
              onChanged: (value) {
                setState(() {
                  esProfSalud = value;
                });
              },
              activeColor: Color(0xFFCEB1BE),
            ),
          onTap: () {
                setState(() {
                  esProfSalud = !esProfSalud;
                });
            }
    );
  }

  licenciaField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Licencia Profesional',
        suffixIcon: Icon(Icons.card_membership),
        contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))
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
              if(mensajeResultante == 'Registro Exitoso'){
                Navigator.of(context).pushNamedAndRemoveUntil('UsuarioPoll', (Route<dynamic> route) =>false);
              }
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
          'FechaNacimiento': fechaNacimiento,
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
          'FechaNacimiento': fechaNacimiento,          
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



  void setBornDate(DateTime bornDate) {
    this.fechaNacimiento = bornDate;
  }
}
