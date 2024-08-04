import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/ui/app_bars/trip_pins_app_bar.dart';
import 'package:trip_pins/ui/maps/editable_map.dart';

class AddPinLocationPage extends StatefulWidget {
  final String tripName;
  final void Function(LatLng location) onLocationSelected;
  final bool shouldGoToAddPinPage;
  const AddPinLocationPage(
      {super.key,
      required this.tripName,
      required this.onLocationSelected,
      required this.shouldGoToAddPinPage});

  @override
  State<AddPinLocationPage> createState() => _AddPinLocationPageState();
}

class _AddPinLocationPageState extends State<AddPinLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TripPinsAppBar(
        title: widget.tripName.isNotEmpty ? widget.tripName : "New Trip Name",
        currentlyAddingPin: true,
      ),
      body: Stack(
        children: [
          EditableMap(
            currentMarkers: [],
            onLocationSelected: widget.onLocationSelected,
            shouldGoToAddPinPage: widget.shouldGoToAddPinPage,
          ),
        ],
      ),
    );
  }
}
