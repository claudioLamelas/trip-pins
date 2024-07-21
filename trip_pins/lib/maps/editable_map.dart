import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/data_types/mock_data.dart';
import 'package:trip_pins/maps/pin_marker.dart';
import 'package:trip_pins/maps/trip_pin.dart';

class EditableMap extends StatefulWidget {
  const EditableMap({super.key});

  @override
  State<EditableMap> createState() => _EditableMapState();
}

class _EditableMapState extends State<EditableMap> {
  List<PinMarker> markers = MockData.getPins()
      .map((pin) => PinMarker(
          point: pin.pinLocation,
          child: TripPin(
            pin: pin,
            onTapCallback: (pin) {},
          )))
      .toList();

  void addMarker(tapPosition, point) {
    setState(() {
      markers.add(
        PinMarker(
          point: point,
          child: TripPin(
            pin: null,
            onTapCallback: (pin) {},
          ),
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
