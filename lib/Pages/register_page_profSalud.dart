import 'package:PsyBrain/models/profesional_salud.dart';
import 'package:PsyBrain/pages/home_page.dart';
import 'package:PsyBrain/utils/login_buttons.dart';
import 'package:PsyBrain/utils/theme_config.dart';
import 'package:flutter/material.dart';



class RegisterPageProfSalud extends StatefulWidget {
  RegisterPageProfSalud({Key key}) : super(key: key);

  @override
  _RegisterPageStateProfSalud createState() => _RegisterPageStateProfSalud();
}

class _RegisterPageStateProfSalud extends State<RegisterPageProfSalud> {

  final _formKey = GlobalKey<FormState>();
  
  String _correo = '';

  String _password = '';
  
  
  String _nombres = '';
  String _apellidos = '';
  String _cedula = '';
  String _fechaNacimiento = '';
  String _telefono = '';
  String _licencia = '';

  

  bool _waitRegister = false;
  bool _error = false;
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: ListView(        
          children: [
            SizedBox(height: 50,),
            correoField(),
            passwordField(),
             Container(child: Divider(), margin: EdgeInsets.symmetric(vertical: 10),),
            nombresField(),
            apellidosField(),
            cedulaField(),
            fechaNacimientoField(),
            licenciaField(),
            SizedBox(height: 50,),
            Column(
              children: [
                botonAdd(context),
                SizedBox(height: 30,),
                _waitRegister ? cargandoRegistro():Container(),              
              ],
            ),         
            _error ? errorMSG():Container(),      //? Si hubo error lo imprime en pantalla.
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
      onChanged: (value) {
        _correo = value;
      },
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },   
      keyboardType: TextInputType.emailAddress,
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
      onChanged: (value) => _cedula = value,
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },
      keyboardType: TextInputType.number,
    );
  }

  Widget fechaNacimientoField(){

    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Fecha Nacimiento',
        helperText: 'Fecha de nacimiento',
        icon: Icon(Icons.calendar_today),                
      ),
      onChanged: (value) {
        _fechaNacimiento = value;
      },
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },   
    );
  }

  Widget botonAdd(BuildContext context) {
    return MyButton(
        action: () async {          
          //? Valida si el formulario esta bien diligenciado.
          if(_formKey.currentState.validate()){
          //? Cambia la variable para que se muestre que esta cargando el registro.          
          setState(() {
            _waitRegister = true;  
          });


            //! Crea una instancia del profesional de la salud, almacena un FireBaseUser en result si todo salió bien. Si no guarda un string.
            final result =  await ProfesionalSalud(
            nombres: _nombres,
            apellidos: _apellidos,
            cedula: _cedula,
            fechaNacimiento: _fechaNacimiento,
            id: _correo,
            password: _password,
            telefono: _telefono,
            licencia: _licencia,
            )
            //! Y a esa instancia le guarda los datos en la DB de Firebase.            
            .guardarDatos();
            //? ctrl y click para ir a la funcion 
            
            
            if(result is String ){
              //? Algo sucedio al crear el usuario.
                setState(() {
              _waitRegister = false;     
              _error = true;
              errorMessage = result;   
            });
            }else {
              //? Se dirige al home con el usuario que se acabó de crear.
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(user: result)), (route) => false);
            }         
          }
        },
        buttonName: 'Crea tu cuenta',
        gradientColors: [Color(0xFFf1e4e8)],
        textColor: Color(0xFFCEB1BE),
        width: 150,
        withShadow: false,
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        helperText: 'Constraseña',
        icon: Icon(Icons.lock_outline),        
      ),      
      onChanged: (value) {
        _password = value;
      },
      validator: (value){
        if(value.isEmpty){
          return 'Campo obligatorio';
        }
        return null;
      },   
    );
  }

  Widget cargandoRegistro() {
    return CircularProgressIndicator(
      
    );
  }

  Widget errorMSG() {
    return Center(
            child: Column(
              children: [
                Text(
                '¡$errorMessage!',
                 style: TextStyle(
                color: color[900],
                fontFamily: 'SourceSansPro',
                fontSize: 20,
                fontWeight: FontWeight.w400
                //fontWeight: FontStyle.italic,
                ),
               ),
              Text(
                'Verifica que todo este correcto',
                 style: TextStyle(
                color: color[900],
                fontFamily: 'SourceSansPro',
                fontSize: 15,
                fontWeight: FontWeight.w400
                //fontWeight: FontStyle.italic,
                ),
              ),
              ],
            ),
          );
  }

  licenciaField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Licencia',
        helperText: 'Licencia profesional. Si aún no la tienes deja este campo vacio.',
        icon: Icon(Icons.card_membership),        
      ),      
      onChanged: (value) {
        _licencia = value;
      },      
      
    );
  }

  
}