import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_pins/ui/pages/add_pin_page.dart';
import 'package:trip_pins/ui/styles.dart';

class TripPinsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool currentlyAddingPin;
  const TripPinsAppBar(
      {super.key, required this.title, required this.currentlyAddingPin});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      title: Text(title),
      actions: currentlyAddingPin
          ? []
          : [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: Styles.primaryButton(width: 130, height: 30),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddPinPage(tripName: title)));
                  },
                  label: const Text("Add Pin"),
                  iconAlignment: IconAlignment.start,
                  icon: const Icon(Icons.add),
                ),
              )
            ],
    );
  }
}
