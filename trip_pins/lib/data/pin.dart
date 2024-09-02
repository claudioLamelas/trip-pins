import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class Pin {
  LatLng? location;
  PinLevel? level;
  String name;
  DateTimeRange? dates;
  List<XFile> photos;
  List<String> notes;

  Pin({
    this.location,
    this.name = "",
    this.dates,
    List<XFile>? photos, // Make photos optional
    List<String>? notes, // Make notes optional
  })  : photos = photos ?? [], // Use null-aware operator to provide default
        notes = notes ?? [];
}

enum PinLevel {
  country,
  city,
  poi,
}
