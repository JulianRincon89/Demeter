import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tiendapp2/listadearticulos.dart';
import 'package:tiendapp2/menuprincipal.dart';

class Compras extends StatefulWidget {
  const Compras({Key? key}) : super(key: key);

  @override
  _ComprasState createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  TextEditingController buscar=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(60, 145, 13, 53),
          title: Text('Compras por negocio'),
        ),
        body: Center(
          child: SizedBox(
            width: 350,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    textAlign: TextAlign.center, textAlignVertical: TextAlignVertical.bottom,
                    controller: buscar,
                    onChanged: (value){
                      setState(() {
                      });
                    },
                    decoration: InputDecoration(hintText: 'Digite el nombre del negocio', hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      helperText: "El nombre del negocio más cercano",
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),
                Expanded(
                    child: BuscarNegocio(capturanegocio: buscar.text))
              ],
            ),

          ),
        )
      )
    );
  }
}

class BuscarNegocio extends StatelessWidget {
  final String capturanegocio;
  final List lista=[];
  BuscarNegocio({Key? key, required this.capturanegocio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> consultarproducto=FirebaseFirestore.instance.collection('productos').where('almacen',isEqualTo: capturanegocio).snapshots();
    return Column(
      children: [
        
        Expanded(
          flex: 3,
          child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: consultarproducto,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
            }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document){
                  Map<String, dynamic> data=document.data()!as Map<String, dynamic>;
                  return DataTable(columns: [
                    DataColumn(label: Text('nombre')),
                    DataColumn(label: Text('precio')),
                  ],
                      rows: [
                       DataRow(selected: true, cells: [
                         DataCell(Text(data['nombre']), onTap: (){
                           lista.add([data['nombre'],data['precio']]);
                           print(lista);
                         },
                         ),
                         DataCell(Text(data['precio']),  onTap: (){
                           lista.add([data['nombre'],data['precio']]);
                           print(lista);
                         },
                         ),
                       ],
                       )
                      ],columnSpacing: 10, dataTextStyle: TextStyle(fontSize: 15, color: Colors.black));/*Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                      ),
                      margin: EdgeInsets.only(top: 10),
                      child: ListTile(
                        title: Text(data['nombre']),
                        subtitle: Text(data['precio']),
                        onTap: (){
                          lista.add([data['nombre'],data['precio']]);
                          //lista.add(data['precio']);
                          print(lista);

                        },

                      ),
                      height: 60,
                  )
                  ]
                  );*/
                }).toList()
              );
            },
          ),
        ),
        ),
        Expanded(child: Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(20),
          height: 100,
          color: Colors.transparent,
          child: ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(100, 105, 13, 145),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ListaCompra(lista:lista)));
              },
              icon: Icon(Icons.shop, size: 20,color: Colors.black,),
              label: Text('Ver Carrito', textAlign: TextAlign.center,)),
        ))
      ],
    );
  }
}
