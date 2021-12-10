import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'gestioncliente.dart';
class ListaCompra extends StatefulWidget {
  List lista=[];
  ListaCompra({required this.lista});
   @override
  _ListaCompraState createState() => _ListaCompraState();
}

class _ListaCompraState extends State<ListaCompra> {


  var total;
  CollectionReference datoscompra=FirebaseFirestore.instance.collection('pedidos');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('lista de artículos'),
          backgroundColor: Color.fromARGB(60, 145, 13, 53),
        ),

      body: Column(
        children: [
            Expanded(
              child: ListView.builder(itemCount: widget.lista.length,
              itemBuilder: (BuildContext context, i){
                final item=widget.lista[i] [0];
              return Dismissible(
                //cuando hay un desplazamiento, el onDismissed
                //el guíon al piso dentro de los parentesis
                onDismissed: (_){
                  widget.lista.removeAt(i);
                },
                movementDuration: Duration(milliseconds: 100),
                key:Key(item),
                    child: ListTile(
                      title: Text(widget.lista[i][0]+ " "+widget.lista[i][1]),
                      //subtitle: Text(widget.lista[i]),
                    ), background: Container(color: Colors.black,),


              );
              },),
            ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              children: [
                Builder(
                builder:(context){
                return ElevatedButton.icon(style: TextButton.styleFrom(padding: EdgeInsets.all(8), backgroundColor: Color.fromARGB(100, 145, 105, 13)),
                onPressed:(){
                  total=0;
                  var tt;
                  for(int i=0; i<widget.lista.length; i++){
                    tt=int.parse(widget.lista[i][1]);
                    total=tt+total;
                    //print(total);
                    Fluttertoast.showToast(msg: 'el valor de la compra es '+' '+total.toString(),
                    backgroundColor: Color.fromARGB(60, 145, 13, 53), fontSize: 25, toastLength: Toast.LENGTH_LONG,
                    textColor: Colors.white, gravity: ToastGravity.CENTER);
                  }
                },
                    label: Text('Cotizar compra'),
                    icon: Icon(Icons.money, size: 20, color: Colors.white,)
                );
                }
                ),
                Container(
                  child: ElevatedButton.icon(
                      onPressed: (){
                        _HojaIngresoUsuario(context);
                        /*total=0;
                        int tt;
                        for(int i=0; i<widget.lista.length; i++){
                          tt=int.parse(widget.lista[i][1]);
                          total=tt+total;
                          //print(total);
                          Fluttertoast.showToast(msg: 'el valor de la compra es '+total.toString(),
                              backgroundColor: Color.fromARGB(60, 145, 13, 53), fontSize: 25, toastLength: Toast.LENGTH_LONG,
                              textColor: Colors.white, gravity: ToastGravity.CENTER);
                        }
                        List listadecompra=[];
                        for(int i=0; i<widget.lista.length; i++){
                          listadecompra.add(widget.lista[i][0]);
                        }
                        //el doc, mandamos el documento que nos sirve como clave en nuestra base de datos.
                        datoscompra.doc().set({
                          'Producto': listadecompra,
                          'Valor compra': total,
                        });*/
                        },
                      icon: Icon(Icons.fifteen_mp, color: Colors.purple,),
                      label: Text('¡Compralo ahora!', textAlign: TextAlign.center,),

                )
                )
              ],
            ),
          )
          ],
      ),
    );
  }
}

void _HojaIngresoUsuario(context){
  final usuario=TextEditingController();
  final password=TextEditingController();
  String usu='';
  String pass='';

  showModalBottomSheet(context: context, builder: (BuildContext bc){
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          child: Text('Identifícate para seguir comprando',
            style:TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight:FontWeight.bold ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: TextField(
            style: TextStyle(color: Colors.black),
            controller: usuario,
            decoration: InputDecoration(
              hintText: 'Usuario',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: TextField(
            style: TextStyle(color: Colors.black),
            controller: password,
            decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black)
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 100, height: 200),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(100, 119, 145, 13),
                    shape: CircleBorder(),
                  ),
                  child: Text('Ingresar',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    usu=usuario.text;
                    pass=password.text;
                    //print(usu+' '+ pass);
                    if(usu=='pepe'&& pass=="123"){
                      SnackBar respuesta = SnackBar(content: Text('Hello $usu'));
                    }
                  },
                ),
              ),
            ),
            Container(
              //padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 100, height: 200),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(100, 119, 145, 13),
                    shape: CircleBorder(),

                  ),
                  child: Text('Registrar',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GestionCliente()),
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  });
  }
