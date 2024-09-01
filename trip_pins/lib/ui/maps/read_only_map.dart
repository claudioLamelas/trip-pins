import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/data/pin.dart';
import 'package:trip_pins/ui/maps/pin_marker.dart';
import 'package:trip_pins/ui/maps/trip_pin.dart';

class ReadOnlyMap extends StatefulWidget {
  final void Function(Pin) onMarkerTap;
  final void Function() onMapTap;
  final List<Pin> pins;
  const ReadOnlyMap(
      {super.key,
      required this.onMarkerTap,
      required this.onMapTap,
      required this.pins});

  @override
  State<ReadOnlyMap> createState() => _ReadOnlyMapState();
}

class _ReadOnlyMapState extends State<ReadOnlyMap> {
  @override
  void initState() {
    super.initState();
  }

  List<PinMarker> _createMarkers() {
    return widget.pins
        .map((pin) => PinMarker(
            point: pin.location ?? const LatLng(0, 0),
            child: TripPin(
              pin: pin,
              onTapCallback: widget.onMarkerTap,
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          initialCenter: LatLng(38.81, -9.17),
          initialZoom: 10,
          onTap: (position, point) {
            widget.onMapTap();
          }),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.claudiolamelas.trippins",
        ),
        MarkerLayer(
          markers: _createMarkers(),
        ),
      ],
    );
  }
}
