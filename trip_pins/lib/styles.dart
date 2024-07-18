import 'package:flutter/material.dart';

class Styles {
  static ButtonStyle primaryButton({double? width, double? height}) {
    return ButtonStyle(
      backgroundColor:
          const WidgetStatePropertyAll(Color.fromARGB(143, 0, 0, 0)),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      fixedSize: (width != null && height != null)
          ? WidgetStatePropertyAll<Size>(Size(width, height))
          : null,
      shape: const WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
