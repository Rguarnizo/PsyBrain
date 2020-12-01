import 'package:PsyBrain/UI/widgets/login_buttons.dart';
import 'package:PsyBrain/Usuario/bloc/bloc_usuario.dart';
import 'package:PsyBrain/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PollScreen extends StatefulWidget {
  PollScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  PollScreenState createState() => PollScreenState();
}

class PollScreenState extends State<PollScreen> {
  UsuarioBloc userBloc;
  final formKey = GlobalKey<FormState>();

  int selectedEdad;
  int selectedFisico;
  int selectedEmocional;
  int selectedCalificacionSaludMental;
  int selectedTristeDosSemanas;
  int selectedEfectoSalud;
  int selectedDiagnostico;
  int selectedUltimoExamen;
  int selectedHistorial;
  int selectedPasadoReciente;
  int selectedMedicacion;
  int selectedHoras;
  int selectedCalidad;
  int selectedMarital;
  int selectedFumador;
  int selectedAlcoholico;
  int selectedPositivismo;

  @override
  void initState() {
    super.initState();

    selectedEdad = 0;
    selectedFisico = 0;
    selectedEmocional = 0;
    selectedCalificacionSaludMental = 0;
    selectedTristeDosSemanas = 0;
    selectedEfectoSalud = 0;
    selectedDiagnostico = 0;
    selectedUltimoExamen = 0;
    selectedHistorial = 0;
    selectedPasadoReciente = 0;
    selectedMedicacion = 0;
    selectedHoras = 0;
    selectedCalidad = 0;
    selectedMarital = 0;
    selectedFumador = 0;
    selectedAlcoholico = 0;
    selectedPositivismo = 0;
  }

  setSelectedEdad(int val) {
    setState(() {
      selectedEdad = val;
    });
  }

  setSelectedFisico(int val) {
    setState(() {
      selectedFisico = val;
    });
  }

  setSelectedEmocional(int val) {
    setState(() {
      selectedEmocional = val;
    });
  }

  setSelectedCalificacionSaludMental(int val) {
    setState(() {
      selectedCalificacionSaludMental = val;
    });
  }

  setSelectedTristeDosSemanas(int val) {
    setState(() {
      selectedTristeDosSemanas = val;
    });
  }

  setSelectedEfectoSalud(int val) {
    setState(() {
      selectedEfectoSalud = val;
    });
  }

  setSelectedDiagnostico(int val) {
    setState(() {
      selectedDiagnostico = val;
    });
  }

  setSelectedUltimoExamen(int val) {
    setState(() {
      selectedUltimoExamen = val;
    });
  }

  setSelectedHistorial(int val) {
    setState(() {
      selectedHistorial = val;
    });
  }

  setSelectedPasadoReciente(int val) {
    setState(() {
      selectedPasadoReciente = val;
    });
  }

  setSelectedMedicacion(int val) {
    setState(() {
      selectedMedicacion = val;
    });
  }

  setSelectedHoras(int val) {
    setState(() {
      selectedHoras = val;
    });
  }

  setSelectedCalidad(int val) {
    setState(() {
      selectedCalidad = val;
    });
  }

  setSelectedMarital(int val) {
    setState(() {
      selectedMarital = val;
    });
  }

  setSelectedFumador(int val) {
    setState(() {
      selectedFumador = val;
    });
  }

  setSelectedAlcoholico(int val) {
    setState(() {
      selectedAlcoholico = val;
    });
  }

  setSelectedPositivismo(int val) {
    setState(() {
      selectedPositivismo = val;
    });
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Por favor completa la encuesta'),
            actions: [
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  bool _verificarEncuesta(BuildContext context) {
    if (selectedEdad == 0 ||
        selectedFisico == 0 ||
        selectedEmocional == 0 ||
        selectedCalificacionSaludMental == 0 ||
        selectedTristeDosSemanas == 0 ||
        selectedEfectoSalud == 0 ||
        selectedDiagnostico == 0 ||
        selectedUltimoExamen == 0 ||
        selectedHistorial == 0 ||
        selectedPasadoReciente == 0 ||
        selectedMedicacion == 0 ||
        selectedHoras == 0 ||
        selectedCalidad == 0 ||
        selectedMarital == 0 ||
        selectedFumador == 0 ||
        selectedAlcoholico == 0 ||
        selectedPositivismo == 0) {
      //print('No se ha completado la encuesta.');
      createAlertDialog(context);
      return false;
    } else {
      //print('Se ha completado la encuesta');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UsuarioBloc>(context);

    return Scaffold(
      body: Center(
        child: new Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                  'Por favor toma unos minutos para llenar esta encuesta acerca del estado general de tu salud mental. Apreciamos tu retroalimentación y tus respuestas se mantendrán en la confidencialidad. Gracias por tu confianza.',
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: const EdgeInsets.all(15.0)),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Genero:'),
                      ListTile(
                        title: const Text('Masculino'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedEdad,
                            onChanged: (val) {
                              setSelectedEdad(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Femenino'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedEdad,
                            onChanged: (val) {
                              setSelectedEdad(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Otros'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedEdad,
                            onChanged: (val) {
                              setSelectedEdad(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Prefiere no decir'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedEdad,
                            onChanged: (val) {
                              setSelectedEdad(val);
                            }),
                      ),
                      Text('Edad'),
                      TextFormField(
                        decoration: InputDecoration(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                      ),
                      Text(
                          'En las ultimas 4 semanas, ¿ Has tenido problemas con tu trabajo o vida diaria debido a tu salud fisica?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedFisico,
                            onChanged: (val) {
                              setSelectedFisico(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedFisico,
                            onChanged: (val) {
                              setSelectedFisico(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No sabe'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedFisico,
                            onChanged: (val) {
                              setSelectedFisico(val);
                            }),
                      ),
                      Text(
                          'En las ultimas 4 semanas, ¿ Has tenido problemas con tu trabajo o vida diaria debido a cualquier problema emocional, como sentirse deprimido, triste o ansioso?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedEmocional,
                            onChanged: (val) {
                              setSelectedEmocional(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedEmocional,
                            onChanged: (val) {
                              setSelectedEmocional(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No sabe'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedEmocional,
                            onChanged: (val) {
                              setSelectedEmocional(val)(val);
                            }),
                      ),
                      Text('En general, ¿Como calificarías tu salud mental?'),
                      ListTile(
                        title: const Text('Excelente'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedCalificacionSaludMental,
                            onChanged: (val) {
                              setSelectedCalificacionSaludMental(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Relativamente bien'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedCalificacionSaludMental,
                            onChanged: (val) {
                              setSelectedCalificacionSaludMental(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Promedio'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedCalificacionSaludMental,
                            onChanged: (val) {
                              setSelectedCalificacionSaludMental(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Relativamente pobre'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedCalificacionSaludMental,
                            onChanged: (val) {
                              setSelectedCalificacionSaludMental(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Pobre'),
                        leading: Radio(
                            value: 5,
                            groupValue: selectedCalificacionSaludMental,
                            onChanged: (val) {
                              setSelectedCalificacionSaludMental(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No estoy seguro'),
                        leading: Radio(
                            value: 6,
                            groupValue: selectedCalificacionSaludMental,
                            onChanged: (val) {
                              setSelectedCalificacionSaludMental(val);
                            }),
                      ),
                      Text(
                          '¿Te has sentido particularmente bajo de animo o triste por más de dos semanas?'),
                      ListTile(
                        title: const Text('Muy seguido'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedTristeDosSemanas,
                            onChanged: (val) {
                              setSelectedTristeDosSemanas(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Relativamente seguido'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedTristeDosSemanas,
                            onChanged: (val) {
                              setSelectedTristeDosSemanas(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No tan seguido'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedTristeDosSemanas,
                            onChanged: (val) {
                              setSelectedTristeDosSemanas(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Para nada'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedTristeDosSemanas,
                            onChanged: (val) {
                              setSelectedTristeDosSemanas(val);
                            }),
                      ),
                      Text(
                          'Durante las ultimas dos semanas, ¿Qué tan seguido ha afectado tu salud mental a tus relaciones?'),
                      ListTile(
                        title: const Text('Muy seguido'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedEfectoSalud,
                            onChanged: (val) {
                              setSelectedEfectoSalud(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Relativamente seguido'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedEfectoSalud,
                            onChanged: (val) {
                              setSelectedEfectoSalud(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No tan seguido'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedEfectoSalud,
                            onChanged: (val) {
                              setSelectedEfectoSalud(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Para nada'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedEfectoSalud,
                            onChanged: (val) {
                              setSelectedEfectoSalud(val);
                            }),
                      ),
                      Text(
                          '¿Has sido diagnosticado con un desorden mental en el pasado?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedDiagnostico,
                            onChanged: (val) {
                              setSelectedDiagnostico(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedDiagnostico,
                            onChanged: (val) {
                              setSelectedDiagnostico(val);
                            }),
                      ),
                      Text(
                          '¿Cuándo fue la ultima vez que te realizaste un examén de salud mental?'),
                      ListTile(
                        title: const Text('Menos de seis meses'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedUltimoExamen,
                            onChanged: (val) {
                              setSelectedUltimoExamen(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Hace seis meses'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedUltimoExamen,
                            onChanged: (val) {
                              setSelectedUltimoExamen(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Hace un año'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedUltimoExamen,
                            onChanged: (val) {
                              setSelectedUltimoExamen(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Más de un año'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedUltimoExamen,
                            onChanged: (val) {
                              setSelectedUltimoExamen(val);
                            }),
                      ),
                      Text(
                          '¿Hay algún historial de desorden mental en tu familia?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedHistorial,
                            onChanged: (val) {
                              setSelectedHistorial(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedHistorial,
                            onChanged: (val) {
                              setSelectedHistorial(val);
                            }),
                      ),
                      Text(
                          '¿Has visto a algún terapista en el pasado reciente?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedPasadoReciente,
                            onChanged: (val) {
                              setSelectedPasadoReciente(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedPasadoReciente,
                            onChanged: (val) {
                              setSelectedPasadoReciente(val);
                            }),
                      ),
                      Text('¿Estas tomando algun tipo de medicación?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedMedicacion,
                            onChanged: (val) {
                              setSelectedMedicacion(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedMedicacion,
                            onChanged: (val) {
                              setSelectedMedicacion(val);
                            }),
                      ),
                      Text('¿Cuántas horas duermes al día?'),
                      ListTile(
                        title: const Text('Menos de 4'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedHoras,
                            onChanged: (val) {
                              setSelectedHoras(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('4-6'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedHoras,
                            onChanged: (val) {
                              setSelectedHoras(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('7-9'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedHoras,
                            onChanged: (val) {
                              setSelectedHoras(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('9+'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedHoras,
                            onChanged: (val) {
                              setSelectedHoras(val);
                            }),
                      ),
                      Text('¿Cómo es la calidad de tu sueño?'),
                      ListTile(
                        title: const Text('Muy mala'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedCalidad,
                            onChanged: (val) {
                              setSelectedCalidad(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Mala'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedCalidad,
                            onChanged: (val) {
                              setSelectedCalidad(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Normal'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedCalidad,
                            onChanged: (val) {
                              setSelectedCalidad(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Buena'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedCalidad,
                            onChanged: (val) {
                              setSelectedCalidad(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Muy buena'),
                        leading: Radio(
                            value: 5,
                            groupValue: selectedCalidad,
                            onChanged: (val) {
                              setSelectedCalidad(val);
                            }),
                      ),
                      Text('¿Cuál es tu estado marital'),
                      ListTile(
                        title: const Text('Casado'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedMarital,
                            onChanged: (val) {
                              setSelectedMarital(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Divorciado'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedMarital,
                            onChanged: (val) {
                              setSelectedMarital(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Separado'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedMarital,
                            onChanged: (val) {
                              setSelectedMarital(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Nunca casado'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedMarital,
                            onChanged: (val) {
                              setSelectedMarital(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Viudo'),
                        leading: Radio(
                            value: 5,
                            groupValue: selectedMarital,
                            onChanged: (val) {
                              setSelectedMarital(val);
                            }),
                      ),
                      Text('¿Eres un fumador activo?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedFumador,
                            onChanged: (val) {
                              setSelectedFumador(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedFumador,
                            onChanged: (val) {
                              setSelectedFumador(val);
                            }),
                      ),
                      Text('¿Eres alcoholico?'),
                      ListTile(
                        title: const Text('Si'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedAlcoholico,
                            onChanged: (val) {
                              setSelectedAlcoholico(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedAlcoholico,
                            onChanged: (val) {
                              setSelectedAlcoholico(val);
                            }),
                      ),
                      Text(
                          '¿Qué tan seguido te sientes positivo acerca de tu vida?'),
                      ListTile(
                        title: const Text('Nunca'),
                        leading: Radio(
                            value: 1,
                            groupValue: selectedPositivismo,
                            onChanged: (val) {
                              setSelectedPositivismo(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('De vez en cuando'),
                        leading: Radio(
                            value: 2,
                            groupValue: selectedPositivismo,
                            onChanged: (val) {
                              setSelectedPositivismo(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Al rededor de la mitad del tiempo'),
                        leading: Radio(
                            value: 3,
                            groupValue: selectedPositivismo,
                            onChanged: (val) {
                              setSelectedPositivismo(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('La mayoria del tiempo'),
                        leading: Radio(
                            value: 4,
                            groupValue: selectedPositivismo,
                            onChanged: (val) {
                              setSelectedPositivismo(val);
                            }),
                      ),
                      ListTile(
                        title: const Text('Siempre'),
                        leading: Radio(
                            value: 5,
                            groupValue: selectedPositivismo,
                            onChanged: (val) {
                              setSelectedPositivismo(val);
                            }),
                      ),
                    ],
                  )),
              Container(
                height: 20,
              ),
              MyButton(
                action: () {
                  if (_verificarEncuesta(context)) {
                    if (formKey.currentState.validate()) {
                      Navigator.pushReplacementNamed(context, 'HomePageUser');
                      userBloc.guardarEncuesta(jsonPoll());
                    }
                  }
                },
                buttonName: 'Terminar Encuesta',
                gradientColors: [color[500], color[800]],
                textColor: Colors.white,
                withShadow: false,
                width: 50,
              ),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> jsonPoll() {
    return {
      'selectedEdad': selectedEdad,
      'selectedFisico': selectedFisico,
      'selectedEmocional': selectedEmocional,
      'selectedCalificacionSaludMental': selectedCalificacionSaludMental,
      'selectedTristeDosSemanas': selectedTristeDosSemanas,
      'selectedEfectoSalud': selectedEfectoSalud,
      'selectedDiagnostico': selectedDiagnostico,
      'selectedUltimoExamen': selectedUltimoExamen,
      'selectedHistorial': selectedHistorial,
      'selectedPasadoReciente': selectedPasadoReciente,
      'selectedMedicacion': selectedMedicacion,
      'selectedHoras': selectedHoras,
      'selectedCalidad': selectedCalidad,
      'selectedMarital': selectedMarital,
      'selectedFumador': selectedFumador,
      'selectedAlcoholico': selectedAlcoholico,
      'selectedPositivismo': selectedPositivismo,
    };
  }
}
