import 'package:PsyBrain/widgets/login_buttons.dart';
import 'package:flutter/material.dart';

class CardProfSalud extends StatelessWidget {
  //TODO: Obtener datos del usuario médico y pintarlos. 
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        CircleAvatar(),
        Column(
          children: [
            Text('Esto es una prueba'),
            MyButton(
              action: () {
                //Navigator.of(context).pushNamed('HomePageProfSalud');
              },
              buttonName: 'Salir de la app',
              gradientColors: [Color(0xFFf1e4e8)],
              textColor: Color(0xFFCEB1BE),
              width: 200.0,
              withShadow: true,
            )
          ],
        )
      ],
    ));
  }
}
