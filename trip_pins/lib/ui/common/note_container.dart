import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_pins/ui/common/expandable_content.dart';
import 'package:trip_pins/ui/pages/add_note_page.dart';

class NoteContainer extends StatelessWidget {
  final String note;
  final void Function(String value) onEditNoteCallback;
  final void Function() onDeleteCallback;
  const NoteContainer(
      {super.key,
      required this.note,
      required this.onDeleteCallback,
      required this.onEditNoteCallback});

  @override
  Widget build(BuildContext context) {
    return ExpandableContent(
      maxHeight: 80,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(color: Colors.black),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddNotePage(
                  onNoteAdded: onEditNoteCallback,
                  isEditable: true,
                  existingNoteValue: note,
                  onDeleteCallback: onDeleteCallback,
                ),
              ),
            );
          },
          onLongPress: onDeleteCallback,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              note,
            ),
          ),
        ),
      ),
    );
  }
}
