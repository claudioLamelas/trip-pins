import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/data/pin.dart';
import 'package:trip_pins/ui/common/location_info_bottom_sheet.dart';
import 'package:trip_pins/ui/maps/pin_marker.dart';
import 'package:trip_pins/ui/maps/trip_pin.dart';
import 'package:trip_pins/ui/pages/add_pin_page.dart';

class EditableMap extends StatefulWidget {
  final List<Pin> currentPins;
  final void Function(LatLng location) onLocationSelected;
  final bool shouldGoToAddPinPage;
  const EditableMap(
      {super.key,
      required this.currentPins,
      required this.onLocationSelected,
      this.shouldGoToAddPinPage = false});

  @override
  State<EditableMap> createState() => _EditableMapState();
}

class _EditableMapState extends State<EditableMap> {
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
  }

  List<PinMarker> _createMarkers() {
    return widget.currentPins
        .map((pin) => PinMarker(
            point: pin.location ?? const LatLng(0, 0),
            child: TripPin(
              pin: pin,
              onTapCallback: (pin) {},
            )))
        .toList();
  }

  void addMarker(LatLng point) {
    widget.onLocationSelected(point);
    setState(() {
      selectedLocation = null;
    });
    if (widget.shouldGoToAddPinPage) {
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => const AddPinPage()));
    } else {
      Navigator.pop(context);
    }
  }

  void showLocationInfo(LatLng point) {
    setState(() {
      selectedLocation = point;
    });
  }

  void hideLocationInfo() {
    setState(() {
      selectedLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(38.81, -9.17),
            initialZoom: 10,
            onTap: (_, point) => showLocationInfo(point),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: "com.claudiolamelas.trippins",
            ),
            MarkerLayer(
              markers: _createMarkers(),
            ),
          ],
        ),
        if (selectedLocation != null)
          LocationInfoBottomSheet(
            location: selectedLocation!,
            onLocationChosen: (LatLng point) => {addMarker(point)},
            onLocationDismissed: hideLocationInfo,
          )
      ],
    );
  }
}
