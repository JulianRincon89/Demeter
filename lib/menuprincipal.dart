import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiendapp2/busquedaactividadnegocio.dart';
import 'package:tiendapp2/busquedaporcategoria.dart';
import 'package:tiendapp2/busquedaxproducto.dart';
import 'package:tiendapp2/compraproductos.dart';
import 'package:tiendapp2/llamadonotificacion.dart';
import 'package:tiendapp2/proveedores.dart';
import 'package:tiendapp2/registronegocios.dart';
import 'package:tiendapp2/search.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Menuprincipal());
}

class Menuprincipal extends StatelessWidget {
  const Menuprincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Bienvenido a DemeterApp'), backgroundColor: Color.fromARGB(100, 145, 13, 53),),
        drawer: MenuLateral(),
        body: menu()
        ),
    );
  }
}
class MenuLateral extends StatelessWidget{
  @override
Widget build(BuildContext context){
    return Drawer(
        child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Demeter-app'),
            accountEmail: Text('misiontic@gmail.com'),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('img/cosecha.jpeg'), fit: BoxFit.cover)),
            ),
          Ink(
            color: Color.fromARGB(100, 105, 13, 145),
          child: ListTile(
            title: Text('Buscar por Actividad', style: TextStyle(color: Colors.black),),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Busquedacategoria()));},
          ),
          ),
          Ink(
            color: Color.fromARGB(100, 145, 13, 119),
            child: ListTile(
              title: Text('Negocios que ofrecen servicios o productos', style: TextStyle(color: Colors.black),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Busquedatiponegocio()));},
            ),
          ),
          Ink(
            color: Color.fromARGB(100, 145, 13, 53),
            child: ListTile(
              title: Text('Negocios', style: TextStyle(color: Colors.black),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> negocios()));},
            ),
          ),
          Ink(
            color: Color.fromARGB(100, 145, 39, 13),
            child: ListTile(
              title: Text('Productos o Servicios', style: TextStyle(color: Colors.black),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> busqueda()));},
            ),
          ),
          Ink(
            color: Color.fromARGB(100, 145, 39, 13),
            child: ListTile(
              title: Text('Mis pedidos', style: TextStyle(color: Colors.black),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Compras()));},
            ),
          ),
          Ink(
            color: Color.fromARGB(100, 145, 105, 13),
            child: ListTile(
              title: Text('Notificaciones', style: TextStyle(color: Colors.black),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Notificaciones()));},
            ),
          ),
          Ink(
            color: Color.fromARGB(100, 119, 145, 13),
            child: ListTile(
              title: Text('Menú Principal', style: TextStyle(color: Colors.black),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Menuprincipal()));},
            ),
          ),
        ],
        ),
    );
  }
}
class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  _menuState createState() => _menuState();
}
class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(100, 145, 39, 13), Colors.white], begin: Alignment.bottomCenter, end: Alignment.topCenter )),
      padding: EdgeInsets.only(bottom: 179, top: 123),
      child:  //botones de menu inferior
        //body con los botones
        ListView(
          shrinkWrap: true,
          children: [
            //primera fila de negocios y productos/servicios
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //columna de negocios
                Column(
                  children: [
                    Container(//Constrained para encerrar el botón y darle estilo
                      child:ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 150, height: 100, ),
                        child: ElevatedButton(
                          child: CircleAvatar(backgroundImage: AssetImage('img/negocios_logo.png'),
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.transparent,
                              shape: CircleBorder()),
                          onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context)=> negocios()));},
                        ),
                      ),
                      padding: EdgeInsets.only(top:10),
                    ),
                    FittedBox(
                      child: Text('Negocios', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25,fontFamily: 'fontbase', fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Column(//columna de productos y servicios
                  children: [
                    Container(//Constrained para encerrar el botón y darle estilo
                      child:ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 150, height: 100, ),
                        child: ElevatedButton(
                          child: CircleAvatar(backgroundImage: AssetImage('img/productos-logo.png'),
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.transparent,
                              shape: CircleBorder()),
                          onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context)=> busqueda()));},
                        ),
                      ),
                      padding: EdgeInsets.only(top:10),
                    ),
                    FittedBox(
                      child: Text('Productos o\nServicios', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25,fontFamily: 'fontbase', fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(//Constrained para encerrar el botón y darle estilo
                      child:ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 150, height: 100, ),
                        child: ElevatedButton(
                          child: CircleAvatar(backgroundImage: AssetImage('img/pedidos-logo.png'),
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.transparent,
                              shape: CircleBorder()),
                          onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context)=> Compras()));},
                        ),
                      ),
                      padding: EdgeInsets.only(top:10),
                    ),
                    FittedBox(
                      child: Text('Mis Pedidos', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25,fontFamily: 'fontbase', fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(//Constrained para encerrar el botón y darle estilo
                      child:ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 150, height: 100, ),
                        child: ElevatedButton(
                          child: CircleAvatar(backgroundImage: AssetImage('img/notificaciones-push.png'),
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.transparent,
                              shape: CircleBorder()),
                          onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context)=> Notificaciones()));},
                        ),
                      ),
                      padding: EdgeInsets.only(top:10),
                    ),
                    FittedBox(
                      child: Text('Notificaciones', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25,fontFamily: 'fontbase', fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
            /*Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    searchbarwidget(),
                  ],
                ),
              ],
            ),*/
          ],
        ) ,

    );

  }
}

