import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'detallenegocio.dart';


class Geolocalizacion extends StatefulWidget {
  final Direccion direccion;
  Geolocalizacion({required this.direccion});

  @override
  _GeolocalizacionState createState() => _GeolocalizacionState();
}

class _GeolocalizacionState extends State<Geolocalizacion> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(widget.direccion.latitud, widget.direccion.longitud),
          zoom: 10),
        ),
      ),
    );
  }
}
