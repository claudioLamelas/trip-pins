import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          Text("data"),
          Text("date"),
        ],
      ),
    );
  }
}
