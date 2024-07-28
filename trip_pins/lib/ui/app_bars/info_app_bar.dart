import 'package:flutter/material.dart';

class InfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const InfoAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      //elevation: 0,
      //backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      title: Text(title),
    );
  }
}
