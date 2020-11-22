import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatPollScreen extends StatefulWidget {
ChatPollScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  ChatPollScreenState createState() => ChatPollScreenState();
}

class ChatPollScreenState extends State<ChatPollScreen> {
  UsuarioBloc userBloc;
  final formKey= GlobalKey<FormState>();
  
  int selectedActitud;
  int selectedInter;
  int selectedDesem;
  
  
  
  @override
  void initState(){
    super.initState();

    selectedActitud=0;
    selectedDesem=0;
    selectedInter=0;
  }

  setSelectedActitud(int val){
    setState(() {
      selectedActitud =val;
    });
  }
  setselectedDesem(int val){
    setState(() {
      selectedDesem =val;
    });
  }
  setselectedInter(int val){
    setState(() {
      selectedInter =val;
    });
  }

  
  createAlertDialog (BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Por favor completa la encuesta'), actions: [ MaterialButton(onPressed: (){Navigator.of(context).pop();},child: Text('Ok') ) ],);

    });
  }
  bool _verificarEncuesta(BuildContext context){
    if(selectedActitud==0 || selectedDesem==0 || selectedInter==0){
      
      //print('No se ha completado la encuesta.');
      createAlertDialog(context);
      return false;
    }
    else{
      print('Se ha completado la encuesta');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UsuarioBloc>(context);

    return Scaffold(

      body: Center(

        child: new Container(
          margin: const EdgeInsets.only(left: 15.0,right: 15.0),
        child: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(15.0)),
            Icon(
              Icons.favorite,
              color: Colors.red[100],
              size: 45.0,
            ),
            Padding(padding: const EdgeInsets.all(15.0)),
            new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: new Text(

              'Califica tu experiencia.',
              textAlign: TextAlign.justify,
              
            ),
            ),
            Padding(padding: const EdgeInsets.all(15.0)),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('De 1 a 5, ¿Cómo calificarías la actitud del profesional?'),
                  ListTile(
                  title: const Text('1'),  
                  leading: Radio(value: 1, groupValue: selectedActitud, 
                  
                    onChanged: (val){
                    setSelectedActitud(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('2'),  
                  leading: Radio(value: 2, groupValue: selectedActitud, 
                  
                    onChanged: (val){
                    setSelectedActitud(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('3'),  
                  leading: Radio(value: 3, groupValue: selectedActitud, 
                  
                    onChanged: (val){
                    setSelectedActitud(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('4'),  
                  leading: Radio(value: 4, groupValue: selectedActitud, 
                  
                    onChanged: (val){
                    setSelectedActitud(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('5'),  
                  leading: Radio(value: 5, groupValue: selectedActitud, 
                  
                    onChanged: (val){
                    setSelectedActitud(val);
                  }),
                  ),
                  
                  
                  Text('De 1 a 5, ¿Qué tan útil consideras la interacción con el profesional?'),
                  ListTile(
                  title: const Text('1'),  
                  leading: Radio(value: 1, groupValue: selectedInter, 
                  
                    onChanged: (val){
                    setselectedInter(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('2'),  
                  leading: Radio(value: 2, groupValue: selectedInter, 
                  
                    onChanged: (val){
                    setselectedInter(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('3'),  
                  leading: Radio(value: 3, groupValue: selectedInter, 
                  
                    onChanged: (val){
                    setselectedInter(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('4'),  
                  leading: Radio(value: 4, groupValue: selectedInter, 
                  
                    onChanged: (val){
                    setselectedInter(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('5'),  
                  leading: Radio(value: 5, groupValue: selectedInter, 
                  
                    onChanged: (val){
                    setselectedInter(val);
                  }),
                  ),
                  Text('En general, de 1 a 5, ¿Cómo calificarías el desempeño del profesional?'),
                  ListTile(
                  title: const Text('1'),  
                  leading: Radio(value: 1, groupValue: selectedDesem, 
                  
                    onChanged: (val){
                    setselectedDesem(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('2'),  
                  leading: Radio(value: 2, groupValue: selectedDesem, 
                  
                    onChanged: (val){
                    setselectedDesem(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('3'),  
                  leading: Radio(value: 3, groupValue: selectedDesem, 
                  
                    onChanged: (val){
                    setselectedDesem(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('4'),  
                  leading: Radio(value: 4, groupValue: selectedDesem, 
                  
                    onChanged: (val){
                    setselectedDesem(val);
                  }),
                  ),
                  ListTile(
                  title: const Text('5'),  
                  leading: Radio(value: 5, groupValue: selectedDesem, 
                  
                    onChanged: (val){
                    setselectedDesem(val);
                  }),
                  ),
                  Text('Aquí puedes dejarnos tus comentarios.'),
                  TextFormField(
                    decoration: InputDecoration(
                      
                    ),
                    validator: (String value){
                      if(value.isEmpty){
                        //return 'Campo requerido';
                      }
                    },
                  ),
                ],
              )
              ),
              Container(height: 20,),
            MyButton(
                  action: (){
                    if(_verificarEncuesta(context)==true){
                    
                    if(!formKey.currentState.validate()){
                      Navigator.pushReplacementNamed(context,'HomePageUser');
                      /*userBloc.guardarEncuesta(jsonPoll());*/
                    }
                    }
                  },
                  buttonName: 'Terminar Encuesta',                  
                  gradientColors: [color[500],color[800]],
                  textColor: Colors.white,
                  withShadow: false,
                  width: 50,
                  
                  ),
                  Container(height: 20,),
          ],
        ),
        ),
      ),
    );
  }

  Map<String,dynamic> jsonAfterChatPoll(){
    return {
        'selectedActitud'                      : selectedActitud,
        'selectedDesem'                    : selectedDesem,
        'selectedInter'                 : selectedInter,
        
    };  
  }
  
}
