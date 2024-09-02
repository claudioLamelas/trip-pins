import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:trip_pins/data/pin.dart';
import 'package:trip_pins/data/trip.dart';
import 'package:trip_pins/providers/new_trip_provider.dart';
import 'package:trip_pins/ui/app_bars/info_app_bar.dart';
import 'package:trip_pins/ui/common/image_container.dart';
import 'package:trip_pins/ui/common/text_field_input.dart';
import 'package:trip_pins/ui/pages/add_pin_location_page.dart';
import 'package:trip_pins/ui/styles.dart';

class AddPinPage extends StatefulWidget {
  final String? tripName;
  final LatLng? pinCoordinates;
  final DateTimeRange? tripDates;
  const AddPinPage(
      {super.key, this.tripName, this.tripDates, this.pinCoordinates});

  @override
  State<AddPinPage> createState() => _AddPinPageState();
}

class _AddPinPageState extends State<AddPinPage> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController pinLocationController;
  late TextEditingController pinDatesController;

  @override
  void initState() {
    super.initState();
  }

  Future pickPinDates(DateTimeRange? pinDates) async {
    Trip currentNewTrip =
        Provider.of<NewTripProvider>(context, listen: false).newTrip;
    DateTimeRange? range = await showDateRangePicker(
        context: context,
        initialDateRange: pinDates,
        firstDate: currentNewTrip.dates?.start ?? DateTime(1900, 1, 1),
        lastDate: currentNewTrip.dates?.end ?? DateTime(2100, 12, 12));

    if (mounted) {
      context.read<NewTripProvider>().setPinDates(range);
    }
  }

  String _buildTripDatePeriod(DateTimeRange? dateRange) {
    return dateRange == null
        ? ""
        : "${dateRange.start.year}/${dateRange.start.month.toString().padLeft(2, '0')}/${dateRange.start.day.toString().padLeft(2, '0')} - ${dateRange.end.year}/${dateRange.end.month.toString().padLeft(2, '0')}/${dateRange.end.day.toString().padLeft(2, '0')}";
  }

  Future addImage() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (mounted) {
      context.read<NewTripProvider>().addPinPhoto(pickedFiles);
    }
  }

  void removeImage(ImageContainer imageToRemove) {
    context.read<NewTripProvider>().removePinPhoto(imageToRemove.file);
  }

  void addNote() {
    context.read<NewTripProvider>().addPinNote("");
  }

  void updatePinLocation(LatLng location) {
    context.read<NewTripProvider>().setPinLocation(location);
  }

  bool isPinInformationValid(Pin pin) {
    return pin.location != null &&
        pin.level != null &&
        pin.name.trim().isNotEmpty &&
        pin.dates != null;
  }

  @override
  Widget build(BuildContext context) {
    Pin pin = context.watch<NewTripProvider>().newPin;
    pinDatesController =
        TextEditingController(text: _buildTripDatePeriod(pin.dates));

    pinLocationController = TextEditingController(
        text: pin.location != null
            ? "${pin.location?.latitude}, ${pin.location?.longitude}"
            : "");

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: InfoAppBar(title: context.watch<NewTripProvider>().newTrip.name),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldInput(
                    isReadOnly: true,
                    controller: pinLocationController,
                    labelText: "Pin Location",
                    flex: 0,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddPinLocationPage(
                                onLocationSelected: updatePinLocation,
                                shouldGoToAddPinPage: false,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.map)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem<PinLevel>(
                            value: PinLevel.country, child: Text("Country")),
                        DropdownMenuItem<PinLevel>(
                            value: PinLevel.city, child: Text("City")),
                        DropdownMenuItem<PinLevel>(
                            value: PinLevel.poi, child: Text("POI")),
                      ],
                      onChanged: (level) =>
                          context.read<NewTripProvider>().setPinLevel(level),
                      decoration: const InputDecoration(
                        labelText: "Pin Level",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  TextFieldInput(
                    labelText: "Pin Name",
                    flex: 0,
                    onChanged: (value) =>
                        context.read<NewTripProvider>().setPinName(value),
                  ),
                  TextFieldInput(
                    controller: pinDatesController,
                    isReadOnly: true,
                    labelText: "Pin Date(s)",
                    flex: 0,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_rounded),
                      onPressed: () => pickPinDates(pin.dates),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: [
                        AddImageButton(
                          addImage: addImage,
                        ),
                        ...pin.photos.map((photo) => ImageContainer(
                              file: photo,
                              onDeleteCallback: removeImage,
                            )),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: pin.notes.length + 1,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 4);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return AddNoteButton(addNote: addNote);
                          } else if (pin.notes.isNotEmpty) {
                            return Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: Colors.red,
                              ),
                            );
                          } else {
                            return null;
                          }
                        }),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: Styles.primaryButton(width: 125, height: 30),
                      onPressed: () {
                        context.read<NewTripProvider>().clearPinInformation();
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: Styles.primaryButton(width: 125, height: 30),
                      onPressed: isPinInformationValid(pin)
                          ? () {
                              context.read<NewTripProvider>().addPin();
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text("Create"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddImageButton extends StatelessWidget {
  final void Function() addImage;
  const AddImageButton({super.key, required this.addImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addImage,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.black),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate_rounded),
                Text("Add Image")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddNoteButton extends StatelessWidget {
  final void Function() addNote;
  const AddNoteButton({super.key, required this.addNote});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addNote,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.black),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.note_add_rounded), Text("Add Note")],
            ),
          ),
        ),
      ),
    );
  }
}
