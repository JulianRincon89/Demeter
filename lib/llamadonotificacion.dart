import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tiendapp2/notificaciones.dart';

import 'menuprincipal.dart';

class Notificaciones extends StatefulWidget {
  const Notificaciones({Key? key}) : super(key: key);

  @override
  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  //initState inicializa el metodo que se acabo de hacer en notificaciones.dart
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final objetonoti=Notificacion();
    objetonoti.notificacion();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(100, 119, 145, 13),
            title: Text("sección de Notificaciones")),
      ),
    );
  }
}
