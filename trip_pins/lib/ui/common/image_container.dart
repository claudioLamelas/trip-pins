import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_pins/ui/pages/full_screen_image_page.dart';

class ImageContainer extends StatefulWidget {
  final XFile file;
  const ImageContainer({super.key, required this.file});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  bool isLongPressed = false;
  bool _isDragged = false;
  GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      key: _containerKey,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: Image.file(File(widget.file.path)).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      onDragStarted: () {
        // Callback when the drag operation starts
        setState(() {
          _isDragged = true; // Update the drag state
        });
      },
      onDragEnd: (details) {
        // Callback when the drag operation ends
        setState(() {
          _isDragged = false; // Update the drag state
        });
      },
      childWhenDragging: Container(
        color: Colors.red,
      ),
      child: GestureDetector(
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

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        onLongPress: () {
          setState(() {
            isLongPressed = true;
          });
        },
        onLongPressEnd: (_) {
          setState(() {
            isLongPressed = false;
          });
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
