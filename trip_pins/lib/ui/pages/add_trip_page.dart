import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:trip_pins/ui/app_bars/info_app_bar.dart';
import 'package:trip_pins/ui/common/text_field_input.dart';
import 'package:trip_pins/ui/maps/read_only_map.dart';
import 'package:trip_pins/ui/pages/add_pin_page.dart';
import 'package:trip_pins/ui/styles.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final TextEditingController tripNameController = TextEditingController();
  late TextEditingController tripDatesController;

  bool shouldDatesBeEmpty = true;
  DateTimeRange tripDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  Color pickerColor = Colors.blue;
  Color pinColor = Colors.red;

  Future pickTripDates() async {
    DateTimeRange? range = await showDateRangePicker(
        context: context,
        initialDateRange: tripDates,
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime(2100, 12, 12));

    if (range != null) {
      setState(() {
        tripDates = range;
        shouldDatesBeEmpty = false;
      });
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future<void> _colorPickerBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
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
                setState(() {
                  pinColor = pickerColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _buildTripDatePeriod(
      DateTimeRange dateRange, bool shouldBeEmptyValue) {
    return shouldBeEmptyValue
        ? ""
        : "${dateRange.start.year}/${dateRange.start.month.toString().padLeft(2, '0')}/${dateRange.start.day.toString().padLeft(2, '0')} - ${dateRange.end.year}/${dateRange.end.month.toString().padLeft(2, '0')}/${dateRange.end.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    tripDatesController = TextEditingController(
        text: _buildTripDatePeriod(tripDates, shouldDatesBeEmpty));

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const InfoAppBar(title: "Add Trip"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldInput(
                labelText: "Trip Name",
                flex: 0,
                controller: tripNameController,
              ),
              Row(
                children: [
                  TextFieldInput(
                    controller: tripDatesController,
                    isReadOnly: true,
                    labelText: "Trip Dates",
                    flex: 3,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_rounded),
                      onPressed: pickTripDates,
                    ),
                  ),
                  const TextFieldInput(labelText: "Trip Score", flex: 1),
                ],
              ),
              const TextFieldInput(
                  labelText: "Description", flex: 0, isMultiLine: true),
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
                  )),
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
                          color: pinColor,
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
                                builder: (context) => AddPinPage(
                                    tripName: tripNameController.text)));
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
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Stack(children: [
                    ReadOnlyMap(onMarkerTap: (pin) {}),
                    const Positioned(top: 5, left: 5, child: Text("Pins")),
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: Styles.primaryButton(width: 125, height: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: Styles.primaryButton(width: 125, height: 30),
                      onPressed: () {},
                      child: const Text("Create"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
