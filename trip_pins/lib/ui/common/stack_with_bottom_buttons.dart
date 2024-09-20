import 'package:flutter/material.dart';

class StackWithBottomButtons extends StatelessWidget {
  final List<Widget> stackChildren;
  final List<Widget> bottomBarChildren;
  const StackWithBottomButtons(
      {super.key,
      required this.stackChildren,
      required this.bottomBarChildren});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ...stackChildren,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...bottomBarChildren,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
