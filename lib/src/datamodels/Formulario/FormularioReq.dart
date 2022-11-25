import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';

class FormularioReq {
  static Color primaryColor = Color(0xFF3949AB);

  static Color secondaryColor = Color(0xFF3949AB);
  String validateEmails(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value))
      return 'Ingrese un correo valido';
    else
      return '';
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: primaryColor),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
  Servicios servicios = new Servicios();

  textinputdet(String text, TextEditingController _controller,
      TextCapitalization textCapitalization, TextInputType textInputType) {
    return Container(

   // decoration: servicios.myBoxDecoration(),
    //  decoration: FormularioReq().myBoxDecoration(),
      child: TextField(

        textAlign: TextAlign.justify,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        controller: _controller,
        enabled: true,
        //obscureText: true,/*    decoration: InputDecoration(
        //                             labelText: 'Your Name',
        //                             border: const OutlineInputBorder(),
        //                             // Display the number of entered characters
        //                             counterText: '${_enteredText.length.toString()} character(s)'),*/
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
          ),

          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
          ),
          labelText: text,

          //   suffixIcon: Icon(Icons.https, color: primaryColor)
        ),
      ),
    );
  }

  ccboTipoDocumento({itemsTipoDOC, onChanged, mySelectionTipoDoc}) {
    return Container(
      decoration: FormularioReq().myBoxDecoration(),
      child: DropdownButtonFormField<dynamic>(
          items: itemsTipoDOC, value: mySelectionTipoDoc, onChanged: onChanged),
    );
  }

  textIngresoDc({controllerNDocumento, maxLengthDOC, onSubmitted}) {
    return Container(
        decoration: FormularioReq().myBoxDecoration(),
        child: TextField(
          keyboardType: TextInputType.phone,
          controller: controllerNDocumento,
          enabled: true,
          maxLength: maxLengthDOC,
          //obscureText: true,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            labelText: 'N° DOCUMENTO IDENTIDAD',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),

              //   suffixIcon: Icon(Icons.https, color: primaryColor)
            ),
          ),
        ));
  }
}
