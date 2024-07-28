import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';

class PinMarker extends Marker {
  const PinMarker(
      {required super.point,
      required super.child,
      super.width = 40,
      super.height = 40,
      super.alignment = Alignment.center,
      super.rotate = true});
}
