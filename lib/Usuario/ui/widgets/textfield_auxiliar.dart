import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldAuxiliar extends StatelessWidget {
  dynamic field;
  final String hintText;
  final IconData icon;
  final TextInputType inputType;
  TextFieldAuxiliar(
      {Key key,
      @required this.field,
      @required this.hintText,
      @required this.icon, this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) return 'Este campo no puede estar vacío';
        return null;
      },
      onSaved: (value) => field = value,
      cursorColor: Color(0xFFf1e4e8),
      //obscureText: true,
      keyboardType: inputType,
      decoration: InputDecoration(
          suffixIcon: Icon(icon),
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFceb1be), width: 2.0),
            borderRadius: BorderRadius.circular(9.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
    );
  }
}
