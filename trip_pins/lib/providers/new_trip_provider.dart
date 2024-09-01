import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/data/pin.dart';
import 'package:trip_pins/data/trip.dart';

class NewTripProvider extends ChangeNotifier {
  Trip newTrip;
  Pin newPin;

  NewTripProvider({required this.newTrip, required this.newPin});

  // New Trip methods
  void setTripName(String name) {
    newTrip.name = name;
    notifyListeners();
  }

  void setTripDates(DateTimeRange? dates) {
    newTrip.dates = dates;
    notifyListeners();
  }

  void setTripScore(String score) {
    newTrip.score = score;
    notifyListeners();
  }

  void setTripDescription(String description) {
    newTrip.description = description;
    notifyListeners();
  }

  void setTripPinsColor(Color pinsColor) {
    newTrip.pinColor = pinsColor;
    notifyListeners();
  }

  void clearTripInformation() {
    newTrip = Trip();
    notifyListeners();
  }

  // New Pin methods
  void setPinLocation(LatLng pinLocation) {
    newPin.location = pinLocation;
    notifyListeners();
  }

  void setPinName(String pinName) {
    newPin.name = pinName;
    notifyListeners();
  }

  void setPinDates(DateTimeRange? pinDates) {
    newPin.dates = pinDates;
    notifyListeners();
  }

  void addPinPhoto(List<XFile> photos) {
    newPin.photos.addAll(photos);
    notifyListeners();
  }

  void removePinPhoto(XFile photoFile) {
    newPin.photos.removeWhere((photo) => photo.path == photoFile.path);
    notifyListeners();
  }

  void addPinNote(String note) {
    newPin.notes.add(note);
    notifyListeners();
  }

  void removeNote(int noteIndex) {
    newPin.notes.removeAt(noteIndex);
    notifyListeners();
  }

  void clearPinInformation() {
    newPin = Pin();
    notifyListeners();
  }

  void addPin() {
    newTrip.pins.add(newPin);
    newPin = Pin();
    notifyListeners();
  }
}
