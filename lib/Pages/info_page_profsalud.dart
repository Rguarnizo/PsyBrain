import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class InfoProfSalud extends StatefulWidget {
  final User user;

  InfoProfSalud({@required this.user,Key key}) : super(key: key){
    obtenerData();
    
  }

    Future<Map> obtenerData() async {

     DocumentReference docRef = FirebaseFirestore.instance.collection('Profesional Salud').doc(user.uid);
     DocumentSnapshot data = await docRef.get();

     dataDB = data.data();
      
      _nombres = dataDB['Nombres'];
      _apellidos = dataDB['Apellidos'];
      _cedula = dataDB['Cedula'];
      _licencia = dataDB['Licencia'];
      _telefono = dataDB['Telefono'];

      return data.data();
      
    }

  Map<String,dynamic> dataDB;

  String _nombres;
  String _apellidos;
  String _cedula;
  String _licencia;
  String _telefono;

  @override
  State<StatefulWidget> createState() => _InfoProfSaludState();

 
}

class _InfoProfSaludState extends State<InfoProfSalud> {

  
  

  TextEditingController _nombresController;
  TextEditingController _apellidosController;
  TextEditingController _cedulaController;
  TextEditingController _licenciaController;
  TextEditingController _telefonoController;


  @override
  void initState(){
    super.initState();
    print(widget.dataDB);
  _nombresController.text =  widget._nombres;
  _apellidosController.text = widget._apellidos;
  _cedulaController.text = widget._cedula;
  _licenciaController.text = widget._licencia;
  _telefonoController.text = widget._telefono;
    
  }


   

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
                radius: 50,              
                child: ClipOval(child: Container(child: Image.network(widget.user.photoURL),)),
              ),
              SizedBox(height: 20,),
              nombresField(),
              apellidosField(),
              cedulaField(),            
              telefonoField(),
              licenciaField(),

          ],
        ),

      ),
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
      controller: _nombresController,
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
      controller: _apellidosController,
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
      controller: _cedulaController,
    );    
  }

   Widget licenciaField() {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Licencia',
          helperText: 'Licencia profesional. Si aún no la tienes deja este campo vacio.',
          icon: Icon(Icons.card_membership),        
        ),      
        controller: _licenciaController,
        
      );    
  }

  Widget telefonoField() {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Telefono',
          helperText: 'Telefono',
          icon: Icon(Icons.phone),        
        ),      
        controller: _telefonoController,        
      );    
  }
}