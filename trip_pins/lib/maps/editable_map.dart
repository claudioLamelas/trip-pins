import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EditableMap extends StatefulWidget {
  const EditableMap({super.key});

  @override
  State<EditableMap> createState() => _EditableMapState();
}

class _EditableMapState extends State<EditableMap> {
  List<Marker> markers = [
    const Marker(
      point: LatLng(38.81, -9.17),
      width: 40,
      height: 40,
      child: FlutterLogo(),
    ),
  ];

  void addMarker(tapPosition, point) {
    setState(() {
      markers.add(
        Marker(
          point: point,
          width: 40,
          height: 40,
          child: const FlutterLogo(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(38.81, -9.17),
        initialZoom: 10,
        onLongPress: addMarker,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.claudiolamelas.trippins",
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}
