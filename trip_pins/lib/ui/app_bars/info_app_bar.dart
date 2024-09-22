import 'package:flutter/material.dart';

class InfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final void Function()? onLeadingPress;
  const InfoAppBar(
      {super.key, required this.title, this.actions, this.onLeadingPress});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            if (onLeadingPress != null) {
              onLeadingPress!();
            }
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      title: Text(title),
      actions: actions,
    );
  }
}
