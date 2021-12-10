import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tiendapp2/detallenegocio.dart';
import 'package:tiendapp2/menuprincipal.dart';

class negocios extends StatelessWidget {
  const negocios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body: Consultanegocios(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(100, 145, 13, 119),
          title: Text('Registro de negocios'),
        ),
        drawer: MenuLateral(),
      )
    );
  }
}

class Consultanegocios extends StatefulWidget {
  const Consultanegocios({Key? key}) : super(key: key);

  @override
  _ConsultanegociosState createState() => _ConsultanegociosState();
}

class _ConsultanegociosState extends State<Consultanegocios> {
  final Stream<QuerySnapshot> consultarnegocio=FirebaseFirestore.instance.collection('negocios').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: consultarnegocio,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text('Hay un error en snapshot');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Text('Cargando...');
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document){
            Map<dynamic, dynamic> data=document.data()! as Map<dynamic,dynamic>;
            return Container(
              child: DataTable(

                  columns: [
              DataColumn(label: Text('+info')),
                  DataColumn(label: Text('nombre')),
                  DataColumn(label: Text('categoria')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Image.network(data['img'], width: 50,), onTap: (){Cliente cli=Cliente(data['nombre'], data['web'], data['img'], data['celular'], data['direccion'], data['categoria'], data['Latitud'], data['Longitud']);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Detallenegocio(cliente:cli)));}),
                    DataCell(Text(data['nombre'], style: TextStyle(fontSize: 13))),
                    DataCell(Text(data['categoria'])),] ),

                ]
              )
            );
          }
          ).toList(),
        );
      },
    );
  }
}

class Cliente{
  String nombre="";
  String web="";
  String imagen="";
  String celular="";
  String direccion="";
  String categoria="";
  String latitud="";
  String longitud="";

  Cliente(this.nombre, this.web, this.imagen, this.celular, this.direccion, this.categoria, this.latitud, this.longitud);
}