import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/model/usuario.dart';
import 'package:PsyBrain/main.dart';
import 'package:flutter/cupertino.dart';
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
  final formKey = GlobalKey<FormState>();

  UsuarioBloc usuarioBloc;
  Map<String,dynamic> userData;
  Widget _page;


   @override
  Widget build(BuildContext context) {

    if(_page == null){
      _page = _createPage(context);
    }
    return _page;
  }


  Widget _createPage(context){
    usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
        

    return  CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Información de perfil')),      
      child: StreamBuilder(
              stream: usuarioBloc.getUserInfo(usuarioBloc.currentUser.uid).asStream(),
              builder: (context, snapshot) {
                if(!snapshot.hasData ){
                  return Container();                  
                }else if(snapshot.connectionState == ConnectionState.done){
                  userData = snapshot.data;               
                  usuarioBloc.usuario = Usuario.fromJson(userData);
                     
                  print('InfoPagePorfSalud: $snapshot');
                  return Form(
                key: formKey,
                child: ListView(
                children: [
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: CircleAvatar(
                        radius: 50,              
                        child: ClipOval(child: Container(child: Image.network(userData['ImageURL']),)),
                      ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(                    
                       children: [
                      SizedBox(height: 20,),
                      nombresField(),
                      Container(height: 20,),
                      apellidosField(),
                      Container(height: 20,),
                      telefonoField(),
                      Container(height: 20,),
                      ]
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: MyButton(action:  (){                   
                            usuarioBloc.actualizarData(userData);                                    
                      },buttonName: 'Actualizar Información',withShadow: true,gradientColors: [color[800]],textColor: Colors.white,),
                    ),
                    SizedBox(height: 100,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: MyButton(action:  (){                   
                            usuarioBloc.actualizarData(userData);                                    
                      },buttonName: 'Eliminar Cuenta',withShadow: true,gradientColors: [Colors.red[400]],textColor: Colors.white,),
                    )

                ],
        ),
              );
                }else{
                  return Container();
                }
              },              
          ),                   
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
      initialValue: usuarioBloc.usuario.nombres,
      onChanged: (value) => userData['Nombres'] = value,
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
      onChanged: (value) => userData['Apellidos'] = value,
      initialValue: usuarioBloc.usuario.apellidos,
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
      onChanged: (value) => userData['Telefono'] = value,
      initialValue: usuarioBloc.usuario.telefono,
    );
  }



}
