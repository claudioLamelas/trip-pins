import 'package:flutter/cupertino.dart';

class DragBar extends StatelessWidget {
  const DragBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FractionallySizedBox(
          widthFactor: 0.3,
          child: Container(
            height: 5,
            decoration: const BoxDecoration(
                color: Color.fromARGB(143, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
    );
  }
}
