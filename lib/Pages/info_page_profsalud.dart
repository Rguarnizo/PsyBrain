import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class InfoProfSalud extends StatefulWidget {
  final User user;

  InfoProfSalud({@required this.user,Key key}) : super(key: key);
    



  @override
  State<StatefulWidget> createState() => _InfoProfSaludState();

 
}

class _InfoProfSaludState extends State<InfoProfSalud> {
  
  Map<String,dynamic> dataDB;

  String _nombres;
  String _apellidos;
  String _cedula;
  String _licencia;
  String _telefono;

  Future<Map<String,dynamic>> obtenerData() async {

     DocumentReference docRef = FirebaseFirestore.instance.collection('Profesional Salud').doc(widget.user.uid);
     DocumentSnapshot data = await docRef.get();
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
          _cedula    = snapshot.data['Cedula'];
          _licencia  = snapshot.data['Licencia'];
          _telefono  = snapshot.data['Telefono'];
         
          

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
                cedulaField(),            
                telefonoField(),
                licenciaField(),

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

  Widget cedulaField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Cedula',
        helperText: 'Cedula',
        icon: Icon(Icons.credit_card),        
      ),      
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },      
      keyboardType: TextInputType.number,
      initialValue: _cedula,
      onChanged: (value) => _cedula = value,
    );    
  }

   Widget licenciaField() {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Licencia',
          helperText: 'Licencia profesional. Si aún no la tienes deja este campo vacio.',
          icon: Icon(Icons.card_membership),        
        ),      
        initialValue: _licencia,
        onChanged: (value) => _licencia = value,
        
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