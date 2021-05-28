import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:app_control_riego/src/utils/constantes.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class AddAbono extends StatefulWidget {
  var cuartel;
  AddAbono({this.cuartel});

  @override
  _AddAbonoState createState() => _AddAbonoState();
}

class _AddAbonoState extends State<AddAbono> {
  TextEditingController nombre = new TextEditingController();
  TextEditingController cantidad = new TextEditingController();
  String medida = "KG";
  

  //Envia los datos recolectados mediante la API
  void addData() {
    http.post(Constantes.API_DIRECION + "cuarteles/" + widget.cuartel['id'].toString() + "/abonos", body: {
      "id_usuario": "1",
      "nombre": nombre.text,
      "cantidad": cantidad.text,
      "medida": medida,       
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Abono"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Nombre de Producto", style: TextStyle(fontSize:18.0),),
              TextField(
                controller: nombre,
                decoration: InputDecoration(
                  hintText: 'Producto',
                ),
              ),

              Text("Cantidad Usada", style: TextStyle(fontSize: 18.0,),),
              TextField(
                controller: cantidad,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Cantidad'
                ),
              ),

              //Switch para seleccionar si la medida es en KG (Kilos) o L (Litros)
              Text("Medida "),
              LiteRollingSwitch(
                value: true,
                textOn: "KG",
                textOff: "L",
                colorOn: Colors.greenAccent,
                colorOff: Colors.indigoAccent,
                textSize: 18.0,
                onChanged: (bool position) {
                  if (position) medida = "KG";
                  else medida = "L"; 
                }
              ),

              RaisedButton(
                child: Text("Agregar"),
                color: Colors.greenAccent,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                onPressed: () {
                  addData();
                  Navigator.pop(context);
                },
              )
            ],
          )
        )
      )
    );
  }
}