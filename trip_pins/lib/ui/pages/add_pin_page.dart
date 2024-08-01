import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_pins/ui/app_bars/info_app_bar.dart';
import 'package:trip_pins/ui/common/image_container.dart';
import 'package:trip_pins/ui/common/text_field_input.dart';
import 'package:trip_pins/ui/styles.dart';

class AddPinPage extends StatefulWidget {
  final String tripName;
  final DateTimeRange? tripDates;
  const AddPinPage({super.key, required this.tripName, this.tripDates});

  @override
  State<AddPinPage> createState() => _AddPinPageState();
}

class _AddPinPageState extends State<AddPinPage> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController pinDatesController;
  late String tripName = widget.tripName;
  DateTimeRange? pinDates;
  List<Widget> images = [];
  List<Widget> notes = [];

  Future pickPinDates() async {
    DateTimeRange? range = await showDateRangePicker(
        context: context,
        initialDateRange: pinDates,
        firstDate: widget.tripDates?.start ?? DateTime(1900, 1, 1),
        lastDate: widget.tripDates?.end ?? DateTime(2100, 12, 12));

    if (range != null) {
      setState(() {
        pinDates = range;
      });
    }
  }

  String _buildTripDatePeriod(DateTimeRange? dateRange) {
    return dateRange == null
        ? ""
        : "${dateRange.start.year}/${dateRange.start.month.toString().padLeft(2, '0')}/${dateRange.start.day.toString().padLeft(2, '0')} - ${dateRange.end.year}/${dateRange.end.month.toString().padLeft(2, '0')}/${dateRange.end.day.toString().padLeft(2, '0')}";
  }

  Future addImage() async {
    // Widget newImage = Container(
    //   height: 30,
    //   width: 30,
    //   decoration: const BoxDecoration(
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(5),
    //     ),
    //     color: Colors.red,
    //   ),
    // );
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    // Widget newImage = ImageContainer(file: ,);
    setState(() {
      images = [
        ...images,
        ...pickedFiles.map((pickedFile) => ImageContainer(file: pickedFile))
      ];
    });
  }

  void addNote() {
    Widget newNote = Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.red,
      ),
    );
    setState(() {
      notes = [...notes, newNote];
    });
  }

  @override
  Widget build(BuildContext context) {
    pinDatesController =
        TextEditingController(text: _buildTripDatePeriod(pinDates));

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar:
          InfoAppBar(title: tripName.isNotEmpty ? tripName : "New Trip Name"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         width: 150,
              //         height: 150,
              //         decoration: BoxDecoration(
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(5)),
              //           border: Border.all(color: Colors.black),
              //         ),
              //         child: ReadOnlyMap(onMarkerTap: (pin) {}),
              //       ),
              //     ),
              //   ],
              // ),
              TextFieldInput(
                labelText: "Pin Location",
                flex: 0,
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.map)),
              ),
              const TextFieldInput(
                labelText: "Pin Name",
                flex: 0,
              ),
              TextFieldInput(
                controller: pinDatesController,
                isReadOnly: true,
                labelText: "Pin Date(s)",
                flex: 0,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month_rounded),
                  onPressed: pickPinDates,
                ),
              ),
              const Divider(),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: [
                  AddImageButton(
                    addImage: addImage,
                  ),
                  ...images,
                ],
              ),
              const Divider(),
              ListView.separated(
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: notes.length + 1,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 4);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return AddNoteButton(addNote: addNote);
                    } else if (notes.isNotEmpty) {
                      return notes[index - 1];
                    } else {
                      return null;
                    }
                  }),
              const Divider(),
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
