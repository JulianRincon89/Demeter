import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                return ElevatedButton.icon(
                onPressed:(){
                  total=0;
                  var tt;
                  for(int i=0; i<widget.lista.length; i++){
                    tt=int.parse(widget.lista[i][1]);
                    total=tt+total;
                    //print(total);
                    Fluttertoast.showToast(msg: 'el valor de la compra es'+total.toString(),
                    backgroundColor: Colors.indigo, fontSize: 25, toastLength: Toast.LENGTH_LONG,
                    textColor: Colors.white, gravity: ToastGravity.CENTER);
                  }
                },
                    label: Text('Cotizar compra'),
                    icon: Icon(Icons.eleven_mp, size: 20, color: Colors.red,)
                );
                }
                ),
                Container(
                  child: ElevatedButton.icon(
                      onPressed: (){
                        total=0;
                        int tt;
                        for(int i=0; i<widget.lista.length; i++){
                          tt=int.parse(widget.lista[i][1]);
                          total=tt+total;
                          //print(total);
                          Fluttertoast.showToast(msg: 'el valor de la compra es'+total.toString(),
                              backgroundColor: Colors.indigo, fontSize: 25, toastLength: Toast.LENGTH_LONG,
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
                        });
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

/*home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de su compra'),
        ),
        body: Center(
          //el builder va a contar el tamaño del arreglo
          child: ListView.builder(itemBuilder: ),
        ),
      )*/