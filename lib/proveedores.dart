import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Proveedores(),
    );
  }
}

class Proveedores extends StatefulWidget {
  const Proveedores({Key? key}) : super(key: key);

  @override
  _ProveedoresState createState() => _ProveedoresState();
}

class _ProveedoresState extends State<Proveedores> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              child: Image.asset('img/logo.png'),
              alignment: Alignment.topLeft,
            )
          ],
        )
        ,
      ),
    );
  }
}
