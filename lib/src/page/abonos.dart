import 'package:flutter/material.dart';

import 'package:app_control_riego/src/utils/constantes.dart';
import 'package:app_control_riego/src/page/addAbono.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Abonos extends StatefulWidget {
  var cuartel;
  Abonos({this.cuartel});
  @override
  _AbonosState createState() => _AbonosState();
}

class _AbonosState extends State<Abonos> {

  //Obtiene los datos de una lista de las abonos que se han hecho en cada cuartel
  Future<List> getData() async {

    final response = await http.get(Constantes.API_DIRECION +"cuarteles/"+ widget.cuartel['id'].toString() + "/abonos");
    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
         onPressed: () => Navigator.of(context).push(MaterialPageRoute(
           builder: (BuildContext context) => AddAbono(cuartel: widget.cuartel,),
         ))
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ?  AbonoList(
            list: snapshot.data,
          )
          : Center(
            child: CircularProgressIndicator() ,
          );
        }
      ),
    );
  } 
}


class AbonoList extends StatelessWidget {
  final List list;
  AbonoList({this.list});

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
                  list[i]['nombre'] + "    " + list[i]['mi_fecha'],
                ),
                subtitle: Text(
                  "Cantidad:  " + list[i]['cantidad'].toString() + list[i]['medida'],
                ) ,
              ),
            ),
          ),
        );
      },
    );
  }

}