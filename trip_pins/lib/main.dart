import 'dart:async';

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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool viewModeActive = false;
  bool showViewModeBar = false;
  Map<String, bool> filtersApplied = {
    "country": true,
    "city": true,
    "poi": true,
  };
  List<Marker> markers = [
    Marker(
      point: LatLng(38.81, -9.17),
      width: 40,
      height: 40,
      child: FlutterLogo(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: !viewModeActive
              ? Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () => {Scaffold.of(context).openDrawer()},
                      icon: const Icon(Icons.menu),
                    );
                  },
                )
              : null,
          title: Visibility(
            visible: !viewModeActive,
            replacement: showViewModeBar
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "View Mode: On",
                        style: TextStyle(
                          backgroundColor: Color.fromARGB(143, 0, 0, 0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Color.fromARGB(143, 0, 0, 0)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    fixedSize: WidgetStatePropertyAll<Size>(Size(190, 30)),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  label: const Text("My Trips"),
                  iconAlignment: IconAlignment.start,
                  icon: const Icon(Icons.pin_drop),
                ),
                ElevatedButton.icon(
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Color.fromARGB(143, 0, 0, 0)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    fixedSize: WidgetStatePropertyAll<Size>(Size(100, 30)),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  label: const Text("Add"),
                  iconAlignment: IconAlignment.start,
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              Text("data"),
              Text("date"),
            ],
          ),
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                  initialCenter: LatLng(38.81, -9.17),
                  initialZoom: 10,
                  onLongPress: (tapPosition, point) {
                    print('Tapped at $point');
                    setState(() {
                      markers.add(
                        Marker(
                          point: point,
                          width: 40,
                          height: 40,
                          child: FlutterLogo(),
                        ),
                      );
                    });
                  }),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "com.claudiolamelas.trippins",
                ),
                MarkerLayer(
                  markers: markers,
                ),
              ],
            ),
            Visibility(
              visible: !viewModeActive,
              child: Positioned(
                top: 100,
                left: 5,
                child: PopupMenuButton<String>(
                  onSelected: (String item) {
                    setState(() {
                      //selectedItem = item;
                    });
                  },
                  //color: Color.fromARGB(143, 0, 0, 0),
                  position: PopupMenuPosition.under,
                  offset: const Offset(0, 10),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "country",
                      child: Row(children: [
                        Checkbox(
                          value: filtersApplied["country"],
                          onChanged: (bool? value) {
                            setState(() {
                              filtersApplied.update(
                                  "country", (current) => value ?? false);
                            });
                          },
                          activeColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        const Text('Country'),
                      ]),
                    ),
                    PopupMenuItem<String>(
                      value: "city",
                      child: Row(children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {},
                          activeColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        const Text('City'),
                      ]),
                    ),
                    PopupMenuItem<String>(
                      value: "poi",
                      child: Row(children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {},
                          activeColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        const Text('POI'),
                      ]),
                    ),
                  ],
                  icon: const Icon(Icons.layers_rounded),
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Color.fromARGB(143, 0, 0, 0)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 5,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    viewModeActive = !viewModeActive;
                    showViewModeBar = true;
                  });
                  Timer(Duration(seconds: 1), () {
                    if (viewModeActive) {
                      setState(() {
                        showViewModeBar = false;
                      });
                    }
                  });
                },
                icon: !viewModeActive
                    ? const Icon(Icons.visibility_rounded)
                    : const Icon(Icons.visibility_off_rounded),
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(143, 0, 0, 0)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
