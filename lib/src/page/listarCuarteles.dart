import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:app_control_riego/src/utils/constantes.dart';
import 'package:app_control_riego/src/page/cuartel.dart';

import 'dart:async';
import 'dart:convert';


class ListarCuarteles extends StatefulWidget {
  _ListarCuartelesState createState() => _ListarCuartelesState();
}


class _ListarCuartelesState extends State<ListarCuarteles> {

  Future<List> getData() async {
    final response = await http.get(Constantes.API_DIRECION + "cuarteles");
    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: new Text("Listado de Cuarteles"),
      ),
      /*
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new addData(),
          ));
        },
        ),*/
        body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
            ? new ItemList(
              list: snapshot.data,
            )
            :new Center (              
              child: new CircularProgressIndicator() ,              
            );
          }
        ),
    );
  }

}


class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
          itemCount:  list == null ? 0 : list.length,
          itemBuilder: (context, i) {
            return new Container(
              padding:const EdgeInsets.all(10.0),
              child: new GestureDetector(
                onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Cuartel(
                      cuartel: list[i],
                    )
                  ),
                ),
                child: new Card(
                  child: new ListTile(
                    title: new Text(
                      list[i]['nombre'] + "  " + list[i]['numero'].toString(),
                      style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                    ),
                  ),
                ),
              ),
            );
          }
    );
  }
}
