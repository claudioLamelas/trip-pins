import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trip_pins/providers/new_trip_provider.dart';

class FullScreenImagePage extends StatelessWidget {
  final XFile file;
  final bool canRemoveImage;
  const FullScreenImagePage(
      {super.key, required this.file, this.canRemoveImage = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.file(File(file.path)),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: canRemoveImage
            ? [
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<NewTripProvider>().removePinPhoto(file);
                    Navigator.pop(context);
                  },
                ),
              ]
            : [],
      ),
    );
  }
}
