import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapMarker extends StatelessWidget {
  const MapMarker({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(title);
      },
      child: FlutterLogo(),
    );
  }
}
