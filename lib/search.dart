import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';

class searchbarwidget extends StatelessWidget {
  //const searchbarwidget({Key? key}) : super(key: key);
  TextEditingController buscar= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(25),
      child: ConstrainedBox(constraints: BoxConstraints.tightFor(width: 300, height: 60, ),
        child: Container(alignment: Alignment.center,
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),),
          child: TextField(
            controller: buscar,
            cursorColor: Color(0xff1976D2), decoration: InputDecoration(
            prefixIcon: Icon(CupertinoIcons.search, color: Colors.lightBlueAccent,
              size: 40.0,
            ),
            suffixIcon: Icon(Icons.article, size: 28.0, color: Colors.cyan),
            border: InputBorder.none,
            hintText: "Buscar por categoría (restaurante, funeraria, etc.)",
            hintStyle: TextStyle(fontFamily: 'fontbase', fontWeight: FontWeight.bold)
          ),
          ),
        ),
      ),
    );
}
}

