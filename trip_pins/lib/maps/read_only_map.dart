import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/common/map_marker.dart';

class ReadOnlyMap extends StatefulWidget {
  const ReadOnlyMap({super.key});

  @override
  State<ReadOnlyMap> createState() => _ReadOnlyMapState();
}

class _ReadOnlyMapState extends State<ReadOnlyMap> {
  List<Marker> markers = [
    const Marker(
      point: LatLng(38.81, -9.17),
      width: 40,
      height: 40,
      child: MapMarker(title: "Test marker"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(38.81, -9.17),
        initialZoom: 10,
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
