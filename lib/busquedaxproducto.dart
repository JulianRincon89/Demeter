import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'menuprincipal.dart';

class busqueda extends StatefulWidget {
  const busqueda({Key? key}) : super(key: key);

  @override
  _busquedaState createState() => _busquedaState();
}

class _busquedaState extends State<busqueda> {
  TextEditingController buscar= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(100, 145, 105, 13),
          title: Text('Buscar productos por nombre') ,
        ),
          drawer: MenuLateral(),
        body: Center(
          child:  SizedBox(
            width: 360,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  textAlign: TextAlign.center, textAlignVertical: TextAlignVertical.bottom,
                  controller: buscar,
                  onChanged: (value){
                    setState(() { });
                  },
                  decoration: InputDecoration(hintText: 'Digite el producto de su interés', hintStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    helperText: "Escriba el nombre del producto",
                    contentPadding: EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  ),
                ),
              Expanded(
                child: Buscardato(
                    capturaproducto: buscar.text,
                ),
              ),
            ],
          ),),
        )
      )

    );
  }
}

class Buscardato extends StatelessWidget {
  final String capturaproducto;
  //a través de los key va a llegar el dato con el buscar
  const Buscardato({Key? key, required this.capturaproducto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //El FirebaseFirestone me permite generar la conexión a la base de datos, el instance, crea la instancia y el colección para escoger la colección.
    //si colocamos FirebaseFirestore.instance.collection('clientes').snapshots() el snapshot es para consulta general.
    final Stream<QuerySnapshot>consulta=FirebaseFirestore.instance.collection('productos').where('nombre', isEqualTo: capturaproducto).snapshots();
    //final Stream<QuerySnapshot>consulta=FirebaseFirestore.instance.collection('clientes').where('idiomas', arrayContainsAny: [capturadato]).snapshots();
    //StreamBuilder ayuda a construir el resultado
    return StreamBuilder<QuerySnapshot>(
      stream: consulta,
      builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        /*if(capturadato.isNotEmpty){
        var t=capturadato.toLowerCase();
        return t;,m
        }*/

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document){
            Map<String, dynamic> data=document.data()! as Map<String,dynamic>;
            return Container(
                child: DataTable(dataRowHeight: 20,
                    columns: [
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text(data['nombre'])),

                    ],
                    rows: [
                      DataRow(cells: [DataCell(Text('Almacen')), DataCell(Text(data['almacen']))],),
                      DataRow(cells: [DataCell(Text('categoria')), DataCell(Text(data['categoria']))],),
                      DataRow(cells: [DataCell(Text('precio')), DataCell(Text(data['precio']))],),
                    ]
                )

              /*ListTile(
                  title: Text(data['nombre']),
                  subtitle: Text(data['categoria']),
              )*/
            );
          }
          ).toList(),
        );
      },
    );
  }
}
