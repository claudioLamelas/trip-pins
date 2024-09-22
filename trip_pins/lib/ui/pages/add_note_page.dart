import 'package:flutter/material.dart';
import 'package:trip_pins/ui/app_bars/info_app_bar.dart';
import 'package:trip_pins/ui/common/stack_with_bottom_buttons.dart';
import 'package:trip_pins/ui/common/text_field_input.dart';
import 'package:trip_pins/ui/styles.dart';

class AddNotePage extends StatefulWidget {
  final void Function(String note) onNoteAdded;
  final String? existingNoteValue;
  final bool isEditable;
  const AddNotePage(
      {super.key,
      required this.onNoteAdded,
      this.existingNoteValue,
      required this.isEditable});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _noteController = TextEditingController();

  bool isNoteValid() => _noteController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _noteController.text = widget.existingNoteValue ?? "";
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const InfoAppBar(title: "Add Note"),
      body: StackWithBottomButtons(
        stackChildren: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldInput(
                  controller: _noteController,
                  textInputType: TextInputType.multiline,
                  labelText: "Note",
                  flex: 1,
                  isMultiLine: true,
                  onChanged: (value) => setState(() {}),
                  isReadOnly: !widget.isEditable,
                  shouldAutoFocus: widget.isEditable,
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ],
        bottomBarChildren: [
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
              onPressed: (isNoteValid()
                  ? () => widget.onNoteAdded(_noteController.text)
                  : null),
              child: Text(widget.existingNoteValue == null ? "Add" : "Save"),
            ),
          ),
        ],
      ),
    );
  }
}
