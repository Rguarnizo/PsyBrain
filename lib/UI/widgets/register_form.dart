import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:PsyBrain/ProfSalud/model/prof_salud.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/Usuario/model/usuario.dart';
import 'package:PsyBrain/UI/widgets/datetime_picker_selector.dart';
import 'package:PsyBrain/Usuario/ui/screens/home_page.dart';
import 'package:PsyBrain/UI/screens/singin_screen.dart';
import 'package:PsyBrain/UI/widgets/textfield_auxiliar.dart';
import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  final String displayName;
  final String email;
  final String uid;
  final UsuarioBloc userBloc;
  final ProfSaludBloc userHealthBloc;

  const RegisterForm(
      {Key key,
      @required this.displayName,
      @required this.email,
      @required this.uid,
      @required this.userBloc,
      @required this.userHealthBloc});
  @override
  _RegisterFormState createState() =>
      _RegisterFormState(displayName, email, uid, userBloc, userHealthBloc);
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final String displayName;
  final String email;
  final String uid;
  String license;
  String phone;
  String identification;
  bool isUserHealth = false;
  DateTime bornDate = DateTime.now();
  final UsuarioBloc userBloc;
  final ProfSaludBloc userHealthBloc;

  _RegisterFormState(this.displayName, this.email, this.uid, this.userBloc,
      this.userHealthBloc);

  void setBornDate(DateTime bornDate) {
    this.bornDate = bornDate;
  }

  void setLicense(String license) {
    this.license = license;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  void setIdentification(String identification) {
    this.identification = identification;
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
                  setField: setPhone,
                  icon: CupertinoIcons.phone,
                  inputType: TextInputType.phone),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20.0),
              child: TextFieldAuxiliar(
                  hintText: 'Ingresa tu número de identificación',
                  setField: setIdentification,
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
                print(isUserHealth);
              },
            ),
            isUserHealth
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 20.0),
                    child: TextFieldAuxiliar(
                      setField: setLicense,
                      hintText: 'Ingresa tu numero de licencia profesional',
                      icon: CupertinoIcons.rectangle_on_rectangle_angled,
                      inputType: TextInputType.number,
                    ))
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: MyButton(
                action: () {
                  //TODO: Revisar campos, algunos faltantes. Campo nombres por Google Auth.
                  setState(() {});
                  print(license);
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

                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.of(context).pop();

                      if (isUserHealth) {
                        ProfSalud user = new ProfSalud(
                          nombres: displayName,
                          apellidos: '',
                          correo: email,
                          fechaNacimiento: bornDate,
                          telefono: phone,
                          licencia: license,
                          cedula: identification,
                        );
                        userHealthBloc.guardarInformacion(user, uid);
                      } else {
                        Usuario user = new Usuario(
                          nombres: displayName,
                          apellidos: '',
                          correo: email,
                          fechaNacimiento: bornDate,
                          telefono: phone,
                        );
                        userBloc.guardarInformacion(user, uid);
                      }

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
