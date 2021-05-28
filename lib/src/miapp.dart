import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_control_riego/src/utils/constantes.dart';

import 'package:app_control_riego/src/page/abonos.dart';
import 'package:app_control_riego/src/page/riegos.dart';
import 'package:app_control_riego/src/page/fumigacion.dart';
import 'package:app_control_riego/src/page/listarCuarteles.dart';  


String username = '';

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Inicio(),
      routes: <String, WidgetBuilder>{
        '/abonoPage' : (BuildContext context) =>  new Abonos(),
        '/riegosPage' : (BuildContext context) => new Riegos(),
        '/fumigacionesPage' : (BuildContext context) => new Fumigaciones(),
        '/Inicio' : (BuildContext context) => new Inicio(),
        '/listarCuarteles' : (BuildContext context) => new ListarCuarteles(),
      },
      
    );
  }
}

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String mensaje = '';

  //Funcion que verifica el login del usuario.
  Future<List> _login() async {
    final response = await http.post(Constantes.API_DIRECION + "login", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);


    if (datauser.length==0){
      setState(() {
        mensaje = "Login Fallo";
      });

    }else{
      //Si el login esta correcto es enviado a la vista de listar cuarteles
      Navigator.pushReplacementNamed(context, '/listarCuarteles');
    

      setState(() {
        username=datauser[0]['username'];
      });
    }

    return datauser;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username", style: TextStyle(fontSize:18.0),),
              TextField(
                controller: user,
                decoration: InputDecoration(
                  hintText: 'Username'
                ),
              ),
              Text("Password", style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
              ),

              RaisedButton(
                child: Text("Ingresar"),
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                color: Colors.green,
                onPressed: () {
                  _login();
                  
                },
              ),

              Text(
                mensaje,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red
                ),
              )
            ],
          ),
        ),
      ), 
      
      );
  }


}