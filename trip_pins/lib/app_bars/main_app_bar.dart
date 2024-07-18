import 'package:flutter/material.dart';

import '../styles.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.viewModeActive,
    required this.showViewModeBar,
  });

  final bool viewModeActive;
  final bool showViewModeBar;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: !viewModeActive
          ? Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => {Scaffold.of(context).openDrawer()},
                  icon: const Icon(Icons.menu),
                );
              },
            )
          : null,
      title: Visibility(
        visible: !viewModeActive,
        replacement: showViewModeBar
            ? Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "View Mode: On",
                    style: TextStyle(
                      backgroundColor: Color.fromARGB(143, 0, 0, 0),
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              style: Styles.primaryButton(width: 190, height: 30),
              onPressed: () {},
              label: const Text("My Trips"),
              iconAlignment: IconAlignment.start,
              icon: const Icon(Icons.pin_drop),
            ),
            ElevatedButton.icon(
              style: Styles.primaryButton(width: 100, height: 30),
              onPressed: () {},
              label: const Text("Add"),
              iconAlignment: IconAlignment.start,
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
