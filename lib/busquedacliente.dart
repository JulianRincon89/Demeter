import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Searchcustomer extends StatelessWidget {
  const Searchcustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
          body: Consultaclientes(),
        )
    );
  }
}

class Consultaclientes extends StatefulWidget {
  const Consultaclientes({Key? key}) : super(key: key);

  @override
  _ConsultaclientesState createState() => _ConsultaclientesState();
}

class _ConsultaclientesState extends State<Consultaclientes> {
  final Stream<QuerySnapshot> consultarcliente=FirebaseFirestore.instance.collection('clientes').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: consultarcliente,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text('Hay un error en snapshot');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Text('Cargando...');
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document){
            Map<String, dynamic> data=document.data()! as Map<String,dynamic>;
            Clientes cli=Clientes(data['nombre'], data['celular'], data['direccion']);
            return Scaffold(
              body: Container(
                child: ListView(
                  children: [
                    Text('Holla'),
                    ]),
                ) ,
              );
            /*Container(
                child: DataTable(

                    columns: [
                      DataColumn(label: Text('+info')),
                      DataColumn(label: Text('nombre')),
                      DataColumn(label: Text('categoria')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Image.network(data['img'], width: 50,), onTap: (){Cliente cli=Cliente(data['nombre'], data['web'], data['img'], data['celular'], data['direccion'], data['categoria']);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Detallenegocio(cliente:cli)));}),
                        DataCell(Text(data['nombre'], style: TextStyle(fontSize: 13))),
                        DataCell(Text(data['categoria'])),] ),

                    ]
                )
            );*/
          }
          ).toList(),
        );
      },
    );
  }
}

class Clientes{
  String nombre="";
  String celular="";
  String direccion="";

  Clientes(this.nombre, this.celular, this.direccion);
}