import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GestionCliente extends StatefulWidget {
  const GestionCliente({Key? key}) : super(key: key);

  @override
  _GestionClienteState createState() => _GestionClienteState();
}

class _GestionClienteState extends State<GestionCliente> {
  final codigo=TextEditingController();
  final nombre=TextEditingController();
  final telefono=TextEditingController();
  final direccion=TextEditingController();
  final web=TextEditingController();
  CollectionReference datoscliente=FirebaseFirestore.instance.collection('clientes');


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Gestión de clientes'), backgroundColor: Color.fromARGB(100, 145,39, 13),),
        body: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(100, 145, 39, 13), Colors.white], begin: Alignment.bottomCenter, end: Alignment.topCenter )),
          child: ListView(
            children: [
              Container(
                height: 70,
                padding: EdgeInsets.only(top: 4, left: 12, right: 12),
                child: TextField(
                  textAlign: TextAlign.center, textAlignVertical: TextAlignVertical.bottom,
                  controller: codigo,
                  decoration: InputDecoration(hintText: 'Cédula', hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      helperText: "Número de cédula",
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                )
              ),
              Container(
                  height: 70,
                  padding: EdgeInsets.only(top: 4, left: 12, right: 12),
                  child: TextField(
                    textAlign: TextAlign.center, textAlignVertical: TextAlignVertical.bottom,
                    controller: nombre,
                    decoration: InputDecoration(hintText: 'Nombres', hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      helperText: "Nombres completos",
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  )
              ),
              Container(
                  height: 70,
                  padding: EdgeInsets.only(top: 4, left: 12, right: 12),
                  child: TextField(
                    textAlign: TextAlign.center, textAlignVertical: TextAlignVertical.bottom,
                    controller: telefono,
                    decoration: InputDecoration(hintText: 'Teléfono', hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      helperText: "Número de teléfono fijo/celular",
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  )
              ),
              Container(
                  height: 70,
                  padding: EdgeInsets.only(top: 4, left: 12, right: 12),
                  child: TextField(
                    textAlign: TextAlign.center, textAlignVertical: TextAlignVertical.bottom,
                    controller: direccion,
                    decoration: InputDecoration(hintText: 'Dirección', hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      helperText: "Dirección domicilio o negoocio.",
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  )
              ),
              Container(
                  height: 70,
                  padding: EdgeInsets.only(top: 4, left: 12, right: 12),
                  child: TextField(
                    textAlign: TextAlign.center, textAlignVertical: TextAlignVertical.bottom,
                    controller: web,
                    decoration: InputDecoration(hintText: 'E-mail', hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      helperText: "Correo electrónico para contactos",
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(60, 156, 43, 18), width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  )
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 2),
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(style: TextButton.styleFrom(padding: EdgeInsets.all(8), backgroundColor: Color.fromARGB(100, 145, 105, 13)),
                        onPressed: (){
                          if(codigo.text.isEmpty||nombre.text.isEmpty||telefono.text.isEmpty||direccion.text.isEmpty||web.text.isEmpty){
                            //metodo toast que muestra un mensaje
                            Fluttertoast.showToast(msg: 'por favor ingrese todos los campos', toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER
                            );
                          }
                          else{
                            datoscliente.doc(codigo.text).set({"nombre": nombre.text,"telefono": telefono.text, "direccion": direccion.text,"web": web.text});
                            Fluttertoast.showToast(msg: "Datos Guardados", fontSize: 20,
                                backgroundColor: Colors.lightBlueAccent,
                                textColor: Colors.black);
                          }
                        },
                        icon: Icon(Icons.people,color: Colors.black, size: 20,),
                        label: Text('Registrar', textAlign: TextAlign.center,)),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 2, right: 2),
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(style: TextButton.styleFrom(padding: EdgeInsets.all(8), backgroundColor: Color.fromARGB(100, 145, 105, 13)),

                        onPressed: (){
                          datoscliente.doc(codigo.text).update({"nombre": nombre.text,"telefono": telefono.text, "direccion": direccion.text,"web": web.text});
                          Fluttertoast.showToast(msg: "Datos Actualizados", fontSize: 20,
                              backgroundColor: Colors.lightBlueAccent,
                              textColor: Colors.yellow);
                        },
                        icon: Icon(Icons.next_plan_outlined,size: 20,color: Colors.black,),
                        label: Text('Actualizar', textAlign: TextAlign.center,)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 2, right: 2),
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(style: TextButton.styleFrom(padding: EdgeInsets.all(8), backgroundColor: Color.fromARGB(100, 145, 105, 13)),

                        onPressed: (){
                          datoscliente.doc(codigo.text).delete();
                          Fluttertoast.showToast(msg: "Datos Eliminados", fontSize: 20,
                              backgroundColor: Colors.lightBlueAccent,
                              textColor: Colors.yellow);
                        },
                        icon: Icon(Icons.delete,size: 20,color: Colors.black,),
                        label: Text('Eliminar', textAlign: TextAlign.center,)
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}
