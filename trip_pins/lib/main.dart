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
            Visibility(
              visible: !viewModeActive,
              child: Positioned(
                top: 100,
                left: 5,
                child: PopupMenuButton<String>(
                  initialValue: "SampleItem.itemOne",
                  onSelected: (String item) {
                    setState(() {
                      //selectedItem = item;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: "SampleItem.itemOne",
                      child: Text('Item 1'),
                    ),
                    const PopupMenuItem<String>(
                      value: "SampleItem.itemTwo",
                      child: Text('Item 2'),
                    ),
                    const PopupMenuItem<String>(
                      value: "SampleItem.itemThree",
                      child: Text('Item 3'),
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
                  Timer(Duration(seconds: 2), () {
                    if (viewModeActive) {
                      setState(() {
                        showViewModeBar = false;
                      });
                    }
                  });
                },
                icon: !viewModeActive
                    ? const Icon(Icons.remove_red_eye_rounded)
                    : const Icon(Icons.cancel_rounded),
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
