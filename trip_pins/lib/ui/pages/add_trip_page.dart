import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:trip_pins/data/trip.dart';
import 'package:trip_pins/providers/new_trip_provider.dart';
import 'package:trip_pins/providers/user_trips_provider.dart';
import 'package:trip_pins/ui/app_bars/info_app_bar.dart';
import 'package:trip_pins/ui/common/stack_with_bottom_buttons.dart';
import 'package:trip_pins/ui/common/text_field_input.dart';
import 'package:trip_pins/ui/maps/read_only_map.dart';
import 'package:trip_pins/ui/pages/add_pin_location_page.dart';
import 'package:trip_pins/ui/pages/add_pin_page.dart';
import 'package:trip_pins/ui/styles.dart';

class AddTripForm extends StatefulWidget {
  const AddTripForm({super.key});

  @override
  State<AddTripForm> createState() => _AddTripFormState();
}

class _AddTripFormState extends State<AddTripForm> {
  final TextEditingController _tripDatesController = TextEditingController();
  final TextEditingController _tripScoreController = TextEditingController();

  @override
  void initState() {
    final NewTripProvider newTripProvider =
        Provider.of<NewTripProvider>(context, listen: false);
    super.initState();
    _tripDatesController.text =
        _buildTripDatePeriod(newTripProvider.newTrip.dates);
    _tripScoreController.addListener(_validateScoreInterval);
  }

  @override
  void dispose() {
    _tripDatesController.dispose();
    _tripScoreController.dispose();
    super.dispose();
  }

  Future pickTripDates(DateTimeRange? initialDateRange) async {
    DateTimeRange? range = await showDateRangePicker(
        context: context,
        initialDateRange: initialDateRange,
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime(2100, 12, 12));

    if (mounted) {
      context.read<NewTripProvider>().setTripDates(range);
    }
  }

  void changeColor(Color color) {
    context.read<NewTripProvider>().setTripPinsColor(color);
  }

  Future<void> _colorPickerBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose a color for the pins'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: context.watch<NewTripProvider>().newTrip.pinColor,
              onColorChanged: changeColor,
              enableAlpha: false,
              paletteType: PaletteType.hsl,
              hexInputBar: true,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Choose Color'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _buildTripDatePeriod(DateTimeRange? dateRange) {
    return dateRange == null
        ? ""
        : "${dateRange.start.year}/${dateRange.start.month.toString().padLeft(2, '0')}/${dateRange.start.day.toString().padLeft(2, '0')} - ${dateRange.end.year}/${dateRange.end.month.toString().padLeft(2, '0')}/${dateRange.end.day.toString().padLeft(2, '0')}";
  }

  void _validateScoreInterval() {
    String text = _tripScoreController.text;
    if (text.isNotEmpty) {
      int? value = int.tryParse(text);
      if (value != null) {
        if (value < 0 || value > 10) {
          // If outside the range, revert to the previous valid value
          _tripScoreController.text = _tripScoreController.value.text
              .substring(0, _tripScoreController.value.text.length - 1);
          _tripScoreController.selection = TextSelection.fromPosition(
            TextPosition(offset: _tripScoreController.text.length),
          );
        }
      }
    }
  }

  void initiateNewPinWithLocation(LatLng location) {
    context.read<NewTripProvider>().setPinLocation(location);
  }

  bool isTripInformationValid(Trip trip) {
    return trip.name.trim().isNotEmpty && trip.dates != null;
  }

  @override
  Widget build(BuildContext context) {
    Trip trip = context.watch<NewTripProvider>().newTrip;
    _tripDatesController.text = _buildTripDatePeriod(trip.dates);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const InfoAppBar(title: "Add Trip"),
      body: StackWithBottomButtons(
        stackChildren: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldInput(
                    labelText: "Name",
                    flex: 0,
                    onChanged: context.read<NewTripProvider>().setTripName,
                  ),
                  Row(
                    children: [
                      TextFieldInput(
                        controller: _tripDatesController,
                        isReadOnly: true,
                        labelText: "Date(s)",
                        flex: 3,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_month_rounded),
                          onPressed: () => pickTripDates(trip.dates),
                        ),
                      ),
                      TextFieldInput(
                        controller: _tripScoreController,
                        textInputType: TextInputType.number,
                        labelText: "Score",
                        textAlign: TextAlign.center,
                        flex: 1,
                        onChanged: (value) =>
                            context.read<NewTripProvider>().setTripScore(value),
                      ),
                    ],
                  ),
                  TextFieldInput(
                    textInputType: TextInputType.multiline,
                    labelText: "Description",
                    flex: 0,
                    isMultiLine: true,
                    onChanged: (value) => context
                        .read<NewTripProvider>()
                        .setTripDescription(value),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.black)),
                      child: const Text(
                        "Participants",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: ElevatedButton.icon(
                          style: Styles.primaryButton(width: 125, height: 20),
                          onPressed: () {
                            _colorPickerBuilder(context);
                          },
                          label: const Text("Pin Color"),
                          icon: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3)),
                              color: trip.pinColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        child: ElevatedButton.icon(
                          style: Styles.primaryButton(width: 125, height: 30),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const AddPinPage()));
                          },
                          label: const Text("Add Pin"),
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Stack(
                        children: [
                          ReadOnlyMap(
                            pins: trip.pins,
                            onMarkerTap: (pin) {},
                            onMapTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => AddPinLocationPage(
                                      onLocationSelected:
                                          initiateNewPinWithLocation,
                                      shouldGoToAddPinPage: true,
                                    ),
                                  ));
                            },
                          ),
                          const Positioned(
                              top: 5, left: 5, child: Text("Pins")),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ],
        bottomBarChildren: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: Styles.primaryButton(width: 125, height: 30),
              onPressed: () {
                context.read<NewTripProvider>().clearTripInformation();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: Styles.primaryButton(width: 125, height: 30),
              onPressed: isTripInformationValid(trip)
                  ? () {
                      context.read<UserTripsProvider>().addTrip(trip);
                      context.read<NewTripProvider>().clearTripInformation();
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text("Create"),
            ),
          ),
        ],
      ),
    );
  }
}

class AddTripPage extends StatelessWidget {
  const AddTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddTripForm();
  }
}
