import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//vamos a hacer un token para que quede registrado el teléfono.
//1. Ir a pubdev y traer firebase-messaging y traemos la dependencia firebase_messaging: ^11.1.0
//Modificar el Androidmanifest agregando el texto   <uses-permission android:name="android.permission.INTERNET"/>
//     <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
//     <uses-permission android:name="android.permission.VIBRATE" />

class Notificacion {
  //esta clase trae 3 métodos, cuando la aplicación está activa, cerrada, y en background.
  FirebaseMessaging push = FirebaseMessaging.instance;

  notificacion() {
    //este nos permite solicitar el permiso y ver el token.
    //la función del then para las conexiones offline, si no hay intenet captura los datos y los deja en el storage y cuando haya conexión devuelve info.
    push.requestPermission();
    push.getToken().then((token) {
      print("Esta imprimiendo el token");
      print(token);
    });
    //listen lo que hace es cómo escuc
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Está en la notificación");
    });
  }
}
