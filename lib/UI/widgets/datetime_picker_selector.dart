import 'package:PsyBrain/UI/widgets/register_form.dart';
import 'package:PsyBrain/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class DateTimePickerSelector extends StatelessWidget {
  final Function setBornDate;

  DateTimePickerSelector({
    Key key,
    @required this.setBornDate,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.withAlpha(155),
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height - 220),
        height: 220.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18.0)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.0),
              height: 140.0,
              child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (value) {
                    setBornDate(value);
                    Vibration.vibrate(duration: 22);
                  },
                  mode: CupertinoDatePickerMode.date),

            ),
            Center(
              child: CupertinoButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Color(0xFFCEB1BE)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
