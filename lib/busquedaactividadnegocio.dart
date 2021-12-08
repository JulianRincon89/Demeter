import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'menuprincipal.dart';

class Busquedatiponegocio extends StatefulWidget {
  const Busquedatiponegocio({Key? key}) : super(key: key);

  @override
  _BusquedatiponegocioState createState() => _BusquedatiponegocioState();
}

class _BusquedatiponegocioState extends State<Busquedatiponegocio> {
  TextEditingController buscar= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(208, 180, 222, 10),
          title: Text('Busqueda por tipo de negocio') ,
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
                  decoration: InputDecoration(hintText: 'Escriba "productos" o "servicios"', hintStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    helperText: "Por favor escriba la categoría",
                    contentPadding: EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Expanded(
                child: Buscardato(
                    capturaactividad: buscar.text,
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
  final String capturaactividad;
  //a través de los key va a llegar el dato con el buscar
  const Buscardato({Key? key, required this.capturaactividad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //El FirebaseFirestone me permite generar la conexión a la base de datos, el instance, crea la instancia y el colección para escoger la colección.
    //si colocamos FirebaseFirestore.instance.collection('clientes').snapshots() el snapshot es para consulta general.
    final Stream<QuerySnapshot>consulta=FirebaseFirestore.instance.collection('negocios').where('tipo', isEqualTo: capturaactividad).snapshots();
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
            return DataTable(dataRowHeight: 20,
                columns: [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text(data['nombre'])),

                ],
                rows: [
                  DataRow(cells: [DataCell(Text('Celular')), DataCell(Text(data['celular']))],),
                  DataRow(cells: [DataCell(Text('Dirección')), DataCell(Text(data['direccion']))],),
                  DataRow(cells: [DataCell(Text('Teléfono')), DataCell(Text(data['telefono']))],),
                  DataRow(cells: [DataCell(Text('Categoría')), DataCell(Text(data['categoria']))],),
                ]
            );
          }
          ).toList(),
        );
      },
    );
  }
}
