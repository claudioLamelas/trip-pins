import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_pins/data/pin.dart';
import 'package:trip_pins/data/trip.dart';
import 'package:trip_pins/firebase_options.dart';
import 'package:trip_pins/providers/new_trip_provider.dart';
import 'package:trip_pins/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider.value(
      value: NewTripProvider(newTrip: Trip(), newPin: Pin()),
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
    // ),
  );
}
