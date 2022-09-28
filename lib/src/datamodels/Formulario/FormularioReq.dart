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

    decoration: servicios.myBoxDecoration(),
    //  decoration: FormularioReq().myBoxDecoration(),
      child: TextField(

        textAlign: TextAlign.center,
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
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),

          border: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          labelText: text,

          //   suffixIcon: Icon(Icons.https, color: primaryColor)
        ),
      ),
    );
  }


  seleccionFecha(
      TextEditingController _controllerFechaInicontrato, String text) {
    /*  return DateTimeField(
      enabled: true,
      decoration: InputDecoration(
        labelText: text,
      ),
      resetIcon: Icon(Icons.calendar_today),
      controller: _controllerFechaInicontrato,
      format: DateFormat("MM-dd-yyyy"),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    ); */
  }

  fechaNacimiento(voidCallback, TextEditingController _controllerFechaNac) {
/*    return DateTimeField(
        format: DateFormat("dd-MM-yyyy"),
        controller: _controllerFechaNac,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
            labelText: 'FECHA NACIMIENTO', suffixIcon: Icon(Icons.date_range)),
        onChanged: voidCallback,
        resetIcon: null,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        }); */
  }

/*  cboDepartamento({dataDepara, onPreset, Departamento depatalits}) {
    return FutureBuilder<List<Departamento>>(
      future: DbProvider.db.getTodosDepartamento(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Departamento>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final preguntas = snapshot.data;

        if (preguntas.length == 0) {
          return Center(
            child: Text("sin dato"),
          );
        } else {
          return Container(
              decoration: FormularioReq().myBoxDecoration(),
              child: DropdownButton<Departamento>(
                underline: SizedBox(),
                isExpanded: true,

                items: snapshot.data
                    .map((user) => DropdownMenuItem<Departamento>(
                          child: Text(user.cidNombre),
                          value: user,
                        ))
                    .toList(),
                onChanged: onPreset,
                //   isExpanded: false,
                value: depatalits,

                hint: Text("   $dataDepara"),
              ));
        }
      },
    );
  } */

  ccboTipoDocumento({itemsTipoDOC, onChanged, mySelectionTipoDoc}) {
    return Container(
      decoration: FormularioReq().myBoxDecoration(),
      child: DropdownButtonFormField<dynamic>(
          items: itemsTipoDOC, value: mySelectionTipoDoc, onChanged: onChanged),
    );
  }

/*  cboProvincia({idDepartamento, datProvincia, onchang}) {
    return FutureBuilder<List<Provincia>>(
      future: DbProvider.db.getTodosProvinciasID(idDepartamento),
      builder: (BuildContext context, AsyncSnapshot<List<Provincia>> snapshot) {
        Provincia provincia;
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final provincias = snapshot.data;

        if (provincias.length == 0) {
          return Center(
            child: Text("sin dato"),
          );
        } else {
          return Container(
              decoration: FormularioReq().myBoxDecoration(),
              child: DropdownButton<Provincia>(
                underline: SizedBox(),
                items: snapshot.data
                    .map((user) => DropdownMenuItem<Provincia>(
                          child: Text(user.cidNombre),
                          value: user,
                        ))
                    .toList(),
                onChanged: onchang,
                isExpanded: true,
                value: provincia,
                hint: Text("   $datProvincia"),
              ));
        }
      },
    );
  } */
/*
  Widget cboDistrito({idProvincia, datDistrito, onChanged}) {
    return FutureBuilder<List<Distrito>>(
      future: DbProvider.db.getTodosDistritoID(idProvincia),
      builder: (BuildContext context, AsyncSnapshot<List<Distrito>> snapshot) {
        Distrito distrito;
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final preguntas = snapshot.data;

        if (preguntas.length == 0) {
          return Center(
            child: Text("sin dato"),
          );
        } else {
          return Container(
              decoration: FormularioReq().myBoxDecoration(),
              child: DropdownButton<Distrito>(
                underline: SizedBox(),
                items: snapshot.data
                    .map((user) => DropdownMenuItem<Distrito>(
                          child: Text(user.cidNombre),
                          value: user,
                        ))
                    .toList(),
                onChanged: onChanged,
                isExpanded: true,
                value: distrito,
                hint: Text("   $datDistrito"),
              ));
        }
      },
    );
  }
 */
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
