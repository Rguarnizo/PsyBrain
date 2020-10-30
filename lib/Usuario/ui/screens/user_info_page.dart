import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UserInfoPage extends StatefulWidget {
  final User user;

  UserInfoPage({@required this.user,Key key}) : super(key: key);




  @override
  _UserInfoPageState createState() => _UserInfoPageState();


}

class _UserInfoPageState extends State<UserInfoPage> {

  Map<String,dynamic> dataDB;

  String _nombres;
  String _apellidos;
  String _fechaNacimiento;
  String _telefono;

  Future<Map<String,dynamic>> obtenerData() async {

    DocumentReference usuarioRef = FirebaseFirestore.instance.collection('Usuario').doc(widget.user.uid);
    DocumentSnapshot data = await usuarioRef.get();
    dataDB = data.data();
    return data.data();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: obtenerData(),
        builder:(context, snapshot) {

          _nombres   = snapshot.data['Nombres'];
          _apellidos = snapshot.data['Apellidos'];
          _telefono  = snapshot.data['Telefono'];
          _fechaNacimiento  = snapshot.data['fechaNacimiento'];



          return Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: [
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {

                  },
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(child: Container(child: Image.network(widget.user.photoURL),)),
                  ),
                ),
                SizedBox(height: 20,),
                nombresField(),
                apellidosField(),
                telefonoField(),
                fechaNacimientoField(),
              ],
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
      initialValue: _nombres,
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
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },
      initialValue: _apellidos,
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
        return null;
      },
      initialValue: _fechaNacimiento,
      onChanged: (value)=> _fechaNacimiento=value,
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
      initialValue: _telefono,
      onChanged: (value) => _telefono = value,
    );
  }


}
