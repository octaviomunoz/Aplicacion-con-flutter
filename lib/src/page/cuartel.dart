import 'package:app_control_riego/src/page/abonos.dart';
import 'package:app_control_riego/src/page/fumigacion.dart';
import 'package:app_control_riego/src/page/riegos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Cuartel extends StatefulWidget {
  var cuartel;
  Cuartel({this.cuartel});
  @override
  _CuartelState createState() => _CuartelState();
}

class _CuartelState extends State<Cuartel> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(
        title: Text(widget.cuartel['nombre'] + "  " + widget.cuartel['numero'].toString()),
        bottom: getTabBar(),
        ),
        body: getTabBarView(<Widget> [
          Riegos(cuartel: widget.cuartel),
          Abonos(cuartel: widget.cuartel),
          Fumigaciones(cuartel: widget.cuartel),          
        ]),
    );
  }

  //Funcion para la tabBar de pestaña
  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab> [
        Tab(text: "Riego",),
        Tab(text: "Abono",),
        Tab(text:  "Fumigacion",),
      ],
      controller: _controller,
    );
  }

  //Funcion que contiene el contenido de cada pestaña
  TabBarView getTabBarView(var displays) {
    return TabBarView(
      children: displays,
      controller: _controller,
      );
  }

}
