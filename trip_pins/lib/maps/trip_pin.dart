import 'package:flutter/material.dart';
import 'package:trip_pins/data_types/pin.dart';

class TripPin extends StatelessWidget {
  final Pin? pin;
  final void Function(Pin) onTapCallback;

  const TripPin({super.key, required this.pin, required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapCallback(pin!);
      },
      child: Container(
          width: 90, height: 90, color: Colors.blue, child: FlutterLogo()),
    );
  }
}
