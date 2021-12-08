import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clientes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido',textAlign: TextAlign.center),
        ),
        body:(
          Consulta()
        ),
      ),
    );
  }
}
class Consulta extends StatefulWidget {
  const Consulta({Key? key}) : super(key: key);

  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  //FirebaseFirestore genera la instancia para conectarse a la colección clientes
  final Stream<QuerySnapshot> consultar=FirebaseFirestore.instance.collection('clientes').snapshots();
  @override
  Widget build(BuildContext context) {
    //atrapar todos los posibles que se pueden generar
    return StreamBuilder<QuerySnapshot>(
      //aquí se guarda la información de la colección
      stream: consultar,
      //aquí se va a generar un árbol de la información.
      // un callback es llamar un método dentro de otro.
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        // si tiene error
        if(snapshot.hasError){
          return Text('Hay un error en snapshot');
        }
        //si es para ver si hubo conexión
        if(snapshot.connectionState==ConnectionState.waiting){
          return Text('Cargando...');
        }
      return ListView(
        //se transforma la data a través del método docs y el map.
        children: snapshot.data!.docs.map((DocumentSnapshot document){
          //ya tenemos los datos y los volvemos string con una clase tipo map y se mapeo a string
          //le digo que en data me guarde lo que queda en document
          Map<String,dynamic> data=document.data()! as Map<String,dynamic>;
          return Container(
            color: Colors.blueAccent,
            margin: EdgeInsets.only(top: 10),
            child: ListTile(
              title: Text(data['nombre'],),
            subtitle: Text(data['direccion']),
          )
          );
        }
        ).toList(),
      );
      },
    );
  }
}
