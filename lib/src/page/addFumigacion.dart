import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:app_control_riego/src/utils/constantes.dart';

class AddFumigacion extends StatefulWidget {
  var cuartel;
  AddFumigacion({this.cuartel});

  @override
  _AddFumigacionState createState() => _AddFumigacionState();
}

class _AddFumigacionState extends State<AddFumigacion> {
  TextEditingController nombre = new TextEditingController();
  

  //Envia los datos mediante una API 
  void addData() {
    http.post(Constantes.API_DIRECION + "cuarteles/" + widget.cuartel['id'].toString() + "/fumigaciones", body: {
      "id_usuario": "1",
      "nombre": nombre.text,    
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Fumigacion"),
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