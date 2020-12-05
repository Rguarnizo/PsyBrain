import 'package:PsyBrain/ProfSalud/UI/widgets/word_card.dart';
import 'package:PsyBrain/ProfSalud/bloc/profsalud_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RelevantWordsCard extends StatelessWidget {
  final ProfSaludBloc userHealthBloc;

  RelevantWordsCard({Key key, @required this.userHealthBloc});

  @override
  Widget build(BuildContext context) {
    getRelevantWords();
    return Padding(
      padding: EdgeInsets.only( left: 5.0, right: 5.0),
      child: Container(
        height: 170.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20.0,
                  color: Colors.grey.shade200,
                  offset: Offset(2, 3),
                  spreadRadius: 1.5)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 27.0, left: 17.0, right: 15.0),
                  child: SvgPicture.network(
                    'https://www.flaticon.es/svg/static/icons/svg/2937/2937015.svg',
                    height: 60.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 27.0,
                  ),
                  child: Container(
                    width: 210.0,
                    child: Text(
                      'Te mostramos las palabras más relevantes de tus chats recientes:',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 17.0),
              child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width - 75,
                  child: FutureBuilder(
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      //print(snapshot.data);
                      if (!snapshot.hasData || snapshot.hasError) {
                        return Container();
                      }
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return WordCard(
                            text: snapshot.data[index]['text'],
                            label: snapshot.data[index]['sentiment']['label'],
                          );
                        },
                      );
                    },
                    future: getRelevantWords(),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> getRelevantWords() async {
    String finalRecopilation = "";
    var analysis = await userHealthBloc.getChatsPS();
    analysis.forEach((element) {
      finalRecopilation += element;
    });
    var response = await userHealthBloc.sendAnalysis(finalRecopilation);
    return response['keywords'];
  }
}
