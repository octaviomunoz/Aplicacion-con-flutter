import 'package:flutter/material.dart';

import 'package:app_control_riego/src/utils/constantes.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Riegos extends StatefulWidget {
  var cuartel;
  Riegos({this.cuartel});
  @override
  _RiegosState createState() => _RiegosState();
}

class _RiegosState extends State<Riegos> {

  //Obtiene los datos de una lista de las riegos que se han hecho en cada cuartel
  Future<List> getData() async {

    final response = await http.get(Constantes.API_DIRECION +"cuarteles/"+ widget.cuartel['id'].toString() + "/riegos");
    return json.decode(response.body);
  }

  //Envia que se ha realizado un riego en la API
  void addData() {
    http.post(Constantes.API_DIRECION + "cuarteles/" + widget.cuartel['id'].toString() + "/riegos", body: {
      "id_usuario": "1",
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {addData();},
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? new RiegoList(
            list: snapshot.data,
          )
          :new Center(
            child: new CircularProgressIndicator() ,
          );
        }
      ),
    );
  } 
}


class RiegoList extends StatelessWidget {
  final List list;
  RiegoList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(
                  "Se rego el  " + list[i]['mi_fecha'],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}