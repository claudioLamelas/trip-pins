import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/ui/maps/pin_marker.dart';

class EditableMap extends StatefulWidget {
  final List<PinMarker> currentMarkers;
  final void Function(LatLng location) onLocationSelected;
  final bool shouldGoToAddPinPage;
  const EditableMap(
      {super.key,
      required this.currentMarkers,
      required this.onLocationSelected,
      this.shouldGoToAddPinPage = false});

  @override
  State<EditableMap> createState() => _EditableMapState();
}

class _EditableMapState extends State<EditableMap> {
  List<PinMarker> markers = [];
  // List<PinMarker> markers = MockData.getPins()
  //     .map((pin) => PinMarker(
  //         point: pin.pinLocation,
  //         child: TripPin(
  //           pin: pin,
  //           onTapCallback: (pin) {},
  //         )))
  //     .toList();

  @override
  void initState() {
    markers = widget.currentMarkers;
    super.initState();
  }

  void addMarker(TapPosition tapPosition, LatLng point) {
    // setState(() {
    //   markers.add(
    //     PinMarker(
    //       point: point,
    //       child: TripPin(
    //         pin: null,
    //         onTapCallback: (pin) {},
    //       ),
    //     ),
    //   );
    // });

    widget.onLocationSelected(point);
    if (widget.shouldGoToAddPinPage) {
      //TODO: Implement the navigation
    } else {
      Navigator.pop(context);
    }
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
