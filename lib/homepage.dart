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
  final Set<Marker> _marker=Set();
  @override
  Widget build(BuildContext context) {

    _marker.add(Marker(markerId: MarkerId(widget.direccion.negocio),
      position: LatLng(widget.direccion.latitud, widget.direccion.longitud),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(
        title: widget.direccion.negocio,
        snippet: widget.direccion.dire
      )
    ),
    );
    print(widget.direccion.latitud);
    print(widget.direccion.longitud);
    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(widget.direccion.latitud, widget.direccion.longitud),
          zoom: 10),
          markers: _marker,
        ),
      ),
    );
  }
}
