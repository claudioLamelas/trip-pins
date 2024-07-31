import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final int flex;
  final bool isMultiLine;
  final bool isReadOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const TextFieldInput({
    super.key,
    required this.labelText,
    required this.flex,
    this.isMultiLine = false,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.isReadOnly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          initialValue: initialValue,
          readOnly: isReadOnly,
          maxLines: isMultiLine ? null : 1,
          minLines: isMultiLine ? null : 1,
          decoration: InputDecoration(
              labelText: labelText,
              border: const OutlineInputBorder(),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon),
        ),
      ),
    );
  }
}
