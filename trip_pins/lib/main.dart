import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trip_pins/common/positioned_button.dart';
import 'package:trip_pins/firebase_options.dart';
import 'package:trip_pins/left_drawer.dart';
import 'package:trip_pins/maps/read_only_map.dart';
import 'package:trip_pins/styles.dart';

import 'app_bars/main_app_bar.dart';

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

  void changeViewModeStatus() {
    setState(() {
      viewModeActive = !viewModeActive;
      showViewModeBar = true;
    });
    Timer(const Duration(seconds: 1), () {
      if (viewModeActive) {
        setState(() {
          showViewModeBar = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MainAppBar(
          viewModeActive: viewModeActive,
          showViewModeBar: showViewModeBar,
        ),
        drawer: const LeftDrawer(),
        body: Stack(
          children: [
            const ReadOnlyMap(),
            Visibility(
              visible: !viewModeActive,
              child: Positioned(
                top: 100,
                left: 5,
                child: PopupMenuButton<String>(
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
                  style: Styles.primaryButton(),
                ),
              ),
            ),
            PositionedButton(
              bottom: 50,
              left: 5,
              icon: Icons.visibility_rounded,
              alternativeStateIcon: Icons.visibility_off_rounded,
              buttonStyle: Styles.primaryButton(),
              isInAlternativeState: viewModeActive,
              onPressed: changeViewModeStatus,
              isVisible: true,
            )
          ],
        ),
      ),
    );
  }
}
