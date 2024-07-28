import 'package:flutter/material.dart';

class PositionedButton extends StatelessWidget {
  const PositionedButton({
    super.key,
    required this.icon,
    required this.buttonStyle,
    required this.isInAlternativeState,
    required this.onPressed,
    this.bottom,
    this.left,
    this.right,
    this.top,
    this.alternativeStateIcon,
    required this.isVisible,
  });

  final double? bottom;
  final double? left;
  final double? right;
  final double? top;
  final IconData icon;
  final IconData? alternativeStateIcon;
  final void Function() onPressed;
  final ButtonStyle buttonStyle;
  final bool isInAlternativeState;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Positioned(
        bottom: bottom,
        left: left,
        right: right,
        top: top,
        child: IconButton(
          onPressed: onPressed,
          icon: !isInAlternativeState ? Icon(icon) : Icon(alternativeStateIcon),
          style: buttonStyle,
        ),
      ),
    );
  }
}
