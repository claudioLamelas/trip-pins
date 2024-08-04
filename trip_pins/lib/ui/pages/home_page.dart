import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trip_pins/data/pin.dart';
import 'package:trip_pins/ui/app_bars/main_app_bar.dart';
import 'package:trip_pins/ui/common/pin_bottom_sheet_info.dart';
import 'package:trip_pins/ui/common/positioned_button.dart';
import 'package:trip_pins/ui/left_drawer.dart';
import 'package:trip_pins/ui/maps/read_only_map.dart';
import 'package:trip_pins/ui/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool viewModeActive = false;
  bool showViewModeBar = false;
  Map<String, bool> filtersApplied = {
    "country": true,
    "city": true,
    "poi": true,
  };

  Pin? selectedPin;

  void selectPin(Pin pin) {
    setState(() {
      if (selectedPin?.pinLocation == pin.pinLocation) {
        selectedPin = null;
      } else {
        selectedPin = pin;
      }
    });
  }

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        viewModeActive: viewModeActive,
        showViewModeBar: showViewModeBar,
      ),
      drawer: const LeftDrawer(),
      body: Stack(
        children: [
          ReadOnlyMap(
            onMarkerTap: selectPin,
            onMapTap: () {},
          ),
          Visibility(
            visible: !viewModeActive,
            child: Positioned(
              top: 100,
              left: 5,
              child: PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                offset: const Offset(0, 10),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
            bottom: 90,
            left: 5,
            icon: Icons.visibility_rounded,
            alternativeStateIcon: Icons.visibility_off_rounded,
            buttonStyle: Styles.primaryButton(),
            isInAlternativeState: viewModeActive,
            onPressed: changeViewModeStatus,
            isVisible: true,
          ),
          selectedPin != null
              ? PinBottomSheetInfo(selectedPin: selectedPin!)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
