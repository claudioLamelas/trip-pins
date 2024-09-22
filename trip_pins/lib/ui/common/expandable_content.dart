import 'package:flutter/material.dart';

class ExpandableContent extends StatefulWidget {
  final Widget child;
  final double maxHeight;
  final bool expandedByDefault;
  final Widget? expandedWidget;

  const ExpandableContent(
      {super.key,
      required this.child,
      required this.maxHeight,
      this.expandedByDefault = false,
      this.expandedWidget});

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  bool isExpanded = false;
  double _childHeight = 0.0;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.expandedByDefault;
  }

  @override
  Widget build(BuildContext context) {
    final childKey = GlobalKey();
    final shouldShowExpandCollapseButton = _childHeight > widget.maxHeight;

    return LayoutBuilder(builder: (context, constraints) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox? renderBox =
            childKey.currentContext?.findRenderObject() as RenderBox?;

        if (renderBox != null && _childHeight != renderBox.size.height) {
          setState(() {
            _childHeight = renderBox.size.height;
          });
        }
      });

      return Column(
        children: [
          AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 200),
            height: !shouldShowExpandCollapseButton || isExpanded
                ? _childHeight
                : widget.maxHeight,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                key: childKey,
                child: isExpanded && widget.expandedWidget != null
                    ? widget.expandedWidget
                    : widget.child,
              ),
            ),
          ),
          if (shouldShowExpandCollapseButton)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                children: [
                  Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                  const SizedBox(width: 4),
                  Text(isExpanded ? 'Show less' : 'Show more'),
                ],
              ),
            ),
        ],
      );
    });
  }
}
