import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_pins/ui/pages/full_screen_image_page.dart';

class ImageContainer extends StatefulWidget {
  final XFile file;
  final void Function(ImageContainer image) onDeleteCallback;
  const ImageContainer({
    super.key,
    required this.file,
    required this.onDeleteCallback,
  });

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FullScreenImagePage(
              file: widget.file,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      onLongPress: () {
        widget.onDeleteCallback(widget);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: Image.file(File(widget.file.path)).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => FullScreenImagePage(file: widget.file),
    //       ),
    //     );
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(8),
    //       image: DecorationImage(
    //         image: Image.file(File(widget.file.path)).image,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    // );
  }
}
