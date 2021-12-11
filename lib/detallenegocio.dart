import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiendapp2/registronegocios.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homepage.dart';

class Detallenegocio extends StatefulWidget {
  final Cliente cliente;
  const Detallenegocio({required this.cliente});

  @override
  _DetallenegocioState createState() => _DetallenegocioState();
}

class _DetallenegocioState extends State<Detallenegocio> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(60, 145, 13, 53),
          title: Text(widget.cliente.nombre),
        ),
          body: Container(
              padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            height: 500,
            width: 350,
            child: Card(
              elevation:10,
              shadowColor: Color.fromARGB(100, 105, 13, 145),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Color.fromARGB(70, 105, 13, 145),
              child: Center(
                child: Column(
                  children: [
                    Image.network(widget.cliente.imagen, width: 200, height: 200,),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(style: TextButton.styleFrom(backgroundColor: Color.fromARGB(100,145, 39, 13)),
                          onPressed: ()async{
                            //await espera el turno para que se ejecuten las líneas antes.
                            if(await canLaunch(widget.cliente.web)){
                              //launch el http.
                              await launch(widget.cliente.web);
                            }
                          },
                          icon: Icon(Icons.public_sharp, size: 30, color: Color.fromARGB(100, 255, 255, 145),),
                          label: Text('Ir a la Web', textAlign: TextAlign.center,)),
                    ),
                    
                  DataTable(
                        columns:
                        [
                          DataColumn(label: Text('Descripción', style: TextStyle(color: Colors.white),)),
                          DataColumn(label: Text('Dato', style: TextStyle(color: Colors.white),)),
                        ],
                      rows:
                      [
                        DataRow(cells: [DataCell(Text('Categoria', style: TextStyle(color: Colors.white),)), DataCell(Text(widget.cliente.categoria, style: TextStyle(color: Colors.white)))]),
                        DataRow(cells: [DataCell(Text('Celular', style: TextStyle(color: Colors.white))), DataCell(Text(widget.cliente.celular, style: TextStyle(color: Colors.white)))]),
                        DataRow(cells: [DataCell(Text('Dirección', style: TextStyle(color: Colors.white))), DataCell(Text(widget.cliente.direccion, style: TextStyle(color: Colors.white))
                        ,onTap: ()async{
                          var la=widget.cliente.latitud;
                          var lo=widget.cliente.longitud;
                          var one=double.parse(la);
                          var two=double.parse(lo);
                          Direccion dir=Direccion(one, two, widget.cliente.nombre, widget.cliente.direccion);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Geolocalizacion(direccion:dir)),
                          );
                            })]),
                      ],
                  ),
                  ],
                )
                ),
              ),
            )
          )
      );
  }
}

class Direccion {
  double latitud;
  double longitud;
  String negocio;
  String dire;
  Direccion(this.latitud, this.longitud, this.negocio, this.dire);

}
