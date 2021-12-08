import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tiendapp2/menuprincipal.dart';
import 'package:tiendapp2/gestioncliente.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pantalla(),
      );
  }
}

class Pantalla extends StatefulWidget {
  //const Pantalla({Key? key}) : super(key: key);

  @override
  _PantallaState createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  final usuario=TextEditingController();
  final password=TextEditingController();
  String usu='';
  String pass='';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('img/fondo3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        /*appBar: AppBar(
          title: Text('Proveapp'),
        ),*/
        body: ListView(
          children: [
            Container(
              //padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Image.asset('img/trigo.png'),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text('¿Estás listo para comprar?',
                style:TextStyle(
                    fontSize: 25,
                color: Colors.black,
                //color: Color.fromARGB(100, 105, 13, 145),
                fontWeight:FontWeight.bold ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: usuario,
                decoration: InputDecoration(
                  hintText: 'Usuario',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: password,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white)
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Menuprincipal()),
                          );
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
        ) ,

      ),
    );
  }
}

class Registrodesplegable extends StatefulWidget {
  const Registrodesplegable({Key? key}) : super(key: key);

  @override
  _RegistrodesplegableState createState() => _RegistrodesplegableState();
}

class _RegistrodesplegableState extends State<Registrodesplegable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawerDragStartBehavior: DragStartBehavior.down,
      body: Stack(
        children: [
          /*Container(
            width: 500,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),*/
          DraggableScrollableSheet(
              maxChildSize: 0.9,
              minChildSize: 0.05,
              initialChildSize: 0.05,
              builder: (context,controller){

            return Container(
              decoration: BoxDecoration(color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              child: SingleChildScrollView(
                //controller le da la animación.
                controller: controller,
                child: Column(
                  children: [

                  ],
                ),
              ),
            );
          }
          )
        ],
      ),
    );
  }
}
