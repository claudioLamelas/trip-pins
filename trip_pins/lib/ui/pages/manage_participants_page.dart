import 'package:flutter/material.dart';
import 'package:trip_pins/ui/app_bars/info_app_bar.dart';
import 'package:trip_pins/ui/common/text_field_input.dart';

class ManageParticipantsPage extends StatefulWidget {
  const ManageParticipantsPage({super.key});

  @override
  State<ManageParticipantsPage> createState() => _ManageParticipantsPageState();
}

class _ManageParticipantsPageState extends State<ManageParticipantsPage> {
  String mode = "search";

  void searchHandler(String value) {
    print("SEARCH: $value");
  }

  void createHandler(String value) {
    print("CREATE: $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const InfoAppBar(title: "Trip Participants"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 115,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButtonFormField(
                        value: mode,
                        selectedItemBuilder: (context) => [
                          const Icon(Icons.search_rounded),
                          const Icon(Icons.add)
                        ],
                        items: const [
                          DropdownMenuItem<String>(
                              value: "search",
                              child: Row(
                                children: [
                                  Icon(Icons.search_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Search"),
                                ],
                              )),
                          DropdownMenuItem<String>(
                              value: "create",
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Create"),
                                ],
                              )),
                        ],
                        onChanged: (modeSelected) => {
                          setState(() {
                            mode = modeSelected ?? "search";
                          })
                        },
                        decoration: const InputDecoration(
                          labelText: "",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0))),
                        ),
                      ),
                    ),
                  ),
                  TextFieldInput(
                    labelText: "Search by name",
                    flex: 1,
                    padding: EdgeInsets.only(right: 8.0),
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(4.0)),
                    onChanged: (text) => mode == "search"
                        ? searchHandler(text)
                        : createHandler(text),
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
