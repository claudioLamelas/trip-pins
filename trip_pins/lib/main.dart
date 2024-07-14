import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_pins/firebase_options.dart';
import 'package:flutter_map/flutter_map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  //LatLng? currenPosition;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () => {Scaffold.of(context).openDrawer()},
              icon: const Icon(Icons.menu),
            );
          }),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Text("data"),
              Text("date"),
            ],
          ),
        ),
        body: Center(
          child: FlutterMap(
            mapController: MapController(),
            options: const MapOptions(
              initialCenter: LatLng(38.81, -9.17),
              initialZoom: 10,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.claudiolamelas.trippins",
              )
            ],
          ),
        ),
      ),
    );
  }
}
