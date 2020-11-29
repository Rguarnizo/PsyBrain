import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoProfSalud extends StatefulWidget {
  InfoProfSalud({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfoProfSaludState();
}

class _InfoProfSaludState extends State<InfoProfSalud> {
  ProfSaludBloc profSaludBloc;
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> userHealtData;
  Widget _page;

  @override
  Widget build(BuildContext context) {
    if (_page == null) {
      _page = _createPage(context);
    }
    return _page;
  }

  Widget _createPage(context) {
    profSaludBloc = BlocProvider.of<ProfSaludBloc>(context);

    return CupertinoPageScaffold(
      navigationBar:
          CupertinoNavigationBar(middle: Text('Información de perfil')),
      child: StreamBuilder(
        stream: profSaludBloc
            .getUserHealthInfo(profSaludBloc.currentUser.uid)
            .asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.done) {
            userHealtData = snapshot.data;
            profSaludBloc.profSalud = ProfSalud.fromJson(userHealtData);

            // print('InfoPagePorfSalud: $snapshot');
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      profSaludBloc.cambiarFotoPerfil();
                    },
                    child: CircleAvatar(
                      radius: (50),
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(snapshot.data['ImageURL'],
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      nombresField(),
                      Container(
                        height: 20,
                      ),
                      apellidosField(),
                      Container(
                        height: 20,
                      ),
                      telefonoField(),
                      Container(
                        height: 20,
                      ),
                      licenciaField(),
                      Container(
                        height: 20,
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: MyButton(
                      action: () {
                        profSaludBloc.actulizarData(userHealtData);
                      },
                      buttonName: 'Actualizar Información',
                      withShadow: true,
                      gradientColors: [color[800]],
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: MyButton(
                      action: () {
                        profSaludBloc.actulizarData(userHealtData);
                      },
                      buttonName: 'Eliminar Cuenta',
                      withShadow: true,
                      gradientColors: [Colors.red[400]],
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            );
          } else {
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
          borderSide: BorderSide(color: Color(0xFFceb1be), width: 2.0),
          borderRadius: BorderRadius.circular(9.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
        hintText: 'Nombres',
        suffixIcon: Icon(Icons.accessibility),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      initialValue: profSaludBloc.profSalud.nombres,
      onChanged: (value) => userHealtData['Nombres'] = value,
    );
  }

  Widget apellidosField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Apellidos',
          suffixIcon: Icon(Icons.account_circle),
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
      onChanged: (value) => userHealtData['Apellidos'] = value,
      initialValue: profSaludBloc.profSalud.apellidos,
    );
  }

  Widget telefonoField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Teléfono',
          suffixIcon: Icon(Icons.phone_android),
          contentPadding: EdgeInsets.only(left: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFceb1be), width: 2.0),
            borderRadius: BorderRadius.circular(9.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      keyboardType: TextInputType.phone,
      onChanged: (value) => userHealtData['Telefono'] = value,
      initialValue: profSaludBloc.profSalud.telefono,
    );
  }

  licenciaField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Licencia Profesional',
          suffixIcon: Icon(Icons.card_membership),
          contentPadding: EdgeInsets.only(left: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFceb1be), width: 2.0),
            borderRadius: BorderRadius.circular(9.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Licencia Obligatoria';
        }
        return null;
      },
      onChanged: (value) => userHealtData['Licencia'] = value,
      initialValue: profSaludBloc.profSalud.licencia,
    );
  }
}
