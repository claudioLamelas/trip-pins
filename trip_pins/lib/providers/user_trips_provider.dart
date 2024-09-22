import 'package:flutter/material.dart';
import 'package:trip_pins/data/trip.dart';

class UserTripsProvider extends ChangeNotifier {
  List<Trip> userTrips;

  UserTripsProvider({required this.userTrips});

  void addTrip(Trip newTrip) {
    userTrips.add(newTrip);
    notifyListeners();
  }
}
