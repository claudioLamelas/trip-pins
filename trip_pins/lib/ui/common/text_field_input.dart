import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final int flex;
  final bool isMultiLine;
  final bool isReadOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool shouldAutoFocus;
  final bool canReceiveFocus;

  const TextFieldInput({
    super.key,
    required this.labelText,
    required this.flex,
    this.isMultiLine = false,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.isReadOnly = false,
    this.textAlign = TextAlign.start,
    this.controller,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.shouldAutoFocus = false,
    this.canReceiveFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      fit: FlexFit.loose,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          textAlign: textAlign,
          keyboardType: textInputType,
          onChanged: onChanged,
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
          autofocus: shouldAutoFocus,
          canRequestFocus: !isReadOnly && canReceiveFocus,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ),
    );
  }
}
