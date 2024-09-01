import 'package:flutter/material.dart';
import 'package:trip_pins/data/pin.dart';

class Trip {
  String name;
  DateTimeRange? dates;
  String score;
  String description;
  Color pinColor;
  List<Pin> pins;

  Trip({
    this.name = "",
    this.dates,
    this.score = "",
    this.description = "",
    this.pinColor = Colors.blue,
    List<Pin>? pins,
  }) : pins = pins ?? [];
}
