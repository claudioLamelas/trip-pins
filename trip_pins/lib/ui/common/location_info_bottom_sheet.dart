import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/ui/common/drag_bar.dart';
import 'package:trip_pins/ui/styles.dart';

class LocationInfoBottomSheet extends StatefulWidget {
  final LatLng location;
  final void Function(LatLng point) onLocationChosen;
  final void Function() onLocationDismissed;

  const LocationInfoBottomSheet(
      {super.key,
      required this.location,
      required this.onLocationChosen,
      required this.onLocationDismissed});

  @override
  State<LocationInfoBottomSheet> createState() =>
      _LocationInfoBottomSheetState();
}

class _LocationInfoBottomSheetState extends State<LocationInfoBottomSheet> {
  final _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onChanged() {
    final currentSize = _controller.size;
    if (currentSize <= 0.05) {
      widget.onLocationDismissed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.3,
      minChildSize: 0,
      expand: true,
      snap: true,
      controller: _controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DragBar(),
                  Text(
                      "${widget.location.latitude.toString()}, ${widget.location.longitude.toString()}"),
                  ElevatedButton(
                    style: Styles.primaryButton(width: 185, height: 30),
                    onPressed: () => widget.onLocationChosen(widget.location),
                    child: const Text("Use as Pin Location"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
