import 'package:flutter/material.dart';
import 'package:trip_pins/ui/app_bars/info_app_bar.dart';
import 'package:trip_pins/ui/common/text_field_input.dart';
import 'package:trip_pins/ui/styles.dart';

class AddPinPage extends StatefulWidget {
  final String tripName;
  const AddPinPage({super.key, required this.tripName});

  @override
  State<AddPinPage> createState() => _AddPinPageState();
}

class _AddPinPageState extends State<AddPinPage> {
  late String tripName = widget.tripName;

  @override
  Widget build(BuildContext context) {
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
                suffixIcon:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.map)),
              ),
              Row(
                children: [
                  TextFieldInput(
                    //controller: _controller,
                    isReadOnly: true,
                    labelText: "Trip Dates",
                    flex: 3,
                    // suffixIcon: IconButton(
                    //   icon: const Icon(Icons.calendar_month_rounded),
                    //   onPressed: pickTripDates,
                    // ),
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
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: ElevatedButton.icon(
                      style: Styles.primaryButton(width: 125, height: 30),
                      onPressed: () {},
                      label: const Text("Add Pin"),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
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
