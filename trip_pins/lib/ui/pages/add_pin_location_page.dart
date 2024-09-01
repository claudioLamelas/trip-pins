import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:trip_pins/data/trip.dart';
import 'package:trip_pins/providers/new_trip_provider.dart';
import 'package:trip_pins/ui/app_bars/trip_pins_app_bar.dart';
import 'package:trip_pins/ui/maps/editable_map.dart';

class AddPinLocationPage extends StatefulWidget {
  final void Function(LatLng location) onLocationSelected;
  final bool shouldGoToAddPinPage;
  const AddPinLocationPage(
      {super.key,
      required this.onLocationSelected,
      required this.shouldGoToAddPinPage});

  @override
  State<AddPinLocationPage> createState() => _AddPinLocationPageState();
}

class _AddPinLocationPageState extends State<AddPinLocationPage> {
  @override
  Widget build(BuildContext context) {
    Trip trip = context.watch<NewTripProvider>().newTrip;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TripPinsAppBar(
        title: trip.name.isNotEmpty ? trip.name : "New Trip Name",
        currentlyAddingPin: true,
      ),
      body: Stack(
        children: [
          EditableMap(
            currentPins: trip.pins,
            onLocationSelected: widget.onLocationSelected,
            shouldGoToAddPinPage: widget.shouldGoToAddPinPage,
          ),
        ],
      ),
    );
  }
}
