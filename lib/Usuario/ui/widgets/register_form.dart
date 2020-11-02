import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/model/usuario.dart';
import 'package:PsyBrain/Usuario/ui/screens/datetime_picker_selector.dart';
import 'package:PsyBrain/Usuario/ui/screens/home_page.dart';
import 'package:PsyBrain/Usuario/ui/screens/singin_screen.dart';
import 'package:PsyBrain/Usuario/ui/widgets/textfield_auxiliar.dart';
import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  final String displayName;
  final String email;
  final String uid;
  final UsuarioBloc userBloc;

  const RegisterForm(
      {Key key,
      @required this.displayName,
      @required this.email,
      this.uid,
      @required this.userBloc});
  @override
  _RegisterFormState createState() =>
      _RegisterFormState(displayName, email, uid, userBloc);
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final String displayName;
  final String email;
  final String uid;
  String phone;
  String identification;
  bool isUserHealth = false;
  DateTime bornDate = DateTime.now();
  final UsuarioBloc userBloc;

  _RegisterFormState(this.displayName, this.email, this.uid, this.userBloc);

  void setBornDate(DateTime bornDate) {
    this.bornDate = bornDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 20.0),
              child: TextFieldAuxiliar(
                  hintText: 'Ingresa tu número de telefono',
                  field: phone,
                  icon: CupertinoIcons.phone,
                  inputType: TextInputType.phone),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20.0),
              child: TextFieldAuxiliar(
                  hintText: 'Ingresa tu número de identificación',
                  field: identification,
                  icon: CupertinoIcons.rectangle_dock,
                  inputType: TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20.0),
              child: InkWell(
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
                      hintText: DateFormat('yyyy/MM/dd').format(bornDate),
                      contentPadding: EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFceb1be), width: 2.0),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                ),
              ),
            ),
            ListTile(
              title: Text('¿Eres usuario de salud?'),
              trailing: CupertinoSwitch(
                value: isUserHealth,
                onChanged: (bool value) {
                  setState(() {
                    isUserHealth = value;
                  });
                },
                activeColor: Color(0xFFCEB1BE),
              ),
              onTap: () {
                setState(() {
                  isUserHealth = !isUserHealth;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: MyButton(
                action: () {
                  //TODO: Revisar campos, algunos faltantes. Campo nombres por Google Auth.
                  Usuario user = new Usuario(
                    nombres: displayName,
                    apellidos: '',
                    correo: email,
                    fechaNacimiento: bornDate,
                    telefono: phone,
                  );
                  if (_formKey.currentState.validate()) {
                    print('hasja00');
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('Tus datos están siendo procesados'),
                          content: CupertinoActivityIndicator(
                            radius: 15.0,
                          ),
                        );
                      },
                    );
                    userBloc.guardarInformacion(user, uid);

                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('¡Todo salió bien!'),
                            content: Text(
                                'Los datos han sido registrados correctamente'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return SignInScreen();
                                    },
                                  ));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    });

                    /*
                    showDialog(
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CupertinoPopupSurface(

                                  child: CupertinoActivityIndicator(

                                  ));
                            } else
                              return CupertinoAlertDialog(
                                title: Text('All good'),
                                content: Text(
                                    'Los datos han sido registrados correctamente'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                          },

                          future:
                              Future.delayed(const Duration(milliseconds: 100)),
                        );
                      },
                    );*/
                  }
                },
                buttonName: 'Registrarse',
                gradientColors: [Color(0xFFf1e4e8)],
                textColor: Color(0xFFCEB1BE),
                width: 155,
                withShadow: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
