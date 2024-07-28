import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/data/mock_data.dart';
import 'package:trip_pins/data/pin.dart';
import 'package:trip_pins/ui/maps/pin_marker.dart';
import 'package:trip_pins/ui/maps/trip_pin.dart';

class ReadOnlyMap extends StatefulWidget {
  final void Function(Pin) onMarkerTap;
  const ReadOnlyMap({super.key, required this.onMarkerTap});

  @override
  State<ReadOnlyMap> createState() => _ReadOnlyMapState();
}

class _ReadOnlyMapState extends State<ReadOnlyMap> {
  List<PinMarker> markers = [];

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    final onTapCallback = widget.onMarkerTap;
    markers = MockData.getPins()
        .map((pin) => PinMarker(
            point: pin.pinLocation,
            child: TripPin(
              pin: pin,
              onTapCallback: onTapCallback,
            )))
        .toList();
  }

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
