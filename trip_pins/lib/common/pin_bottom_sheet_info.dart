import 'package:flutter/material.dart';
import 'package:trip_pins/data_types/pin.dart';

class PinBottomSheetInfo extends StatefulWidget {
  final Pin selectedPin;
  const PinBottomSheetInfo({super.key, required this.selectedPin});

  @override
  State<PinBottomSheetInfo> createState() => _PinBottomSheetInfoState();
}

class _PinBottomSheetInfoState extends State<PinBottomSheetInfo>
    with TickerProviderStateMixin {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();
  late PageController _pageViewController;
  late TabController _tabController;
  PinViewMode currentPinViewMode = PinViewMode.standard;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
    _pageViewController = PageController();
    _tabController =
        TabController(vsync: this, length: widget.selectedPin.pinsData.length);
  }

  @override
  void didUpdateWidget(covariant PinBottomSheetInfo oldWidget) {
    _tabController =
        TabController(vsync: this, length: widget.selectedPin.pinsData.length);
    super.didUpdateWidget(oldWidget);
  }

  void _onChanged() {
    final currentSize = _controller.size;
    currentPinViewMode = _getPinViewMode();
    if (currentSize <= 0.05) _collapse();
  }

  void _collapse() => _animateSheet(sheet.snapSizes!.first);

  void _initial() => _animateSheet(sheet.initialChildSize);

  void _expand() => _animateSheet(sheet.maxChildSize);

  void _hide() => _animateSheet(sheet.minChildSize);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  DraggableScrollableSheet get sheet =>
      (_sheet.currentWidget as DraggableScrollableSheet);

  void onPinViewChanged(int index) {
    _tabController.index = index;
  }

  PinViewMode _getPinViewMode() {
    return _controller.size == sheet.snapSizes!.first
        ? PinViewMode.collapsed
        : _controller.size == sheet.snapSizes!.last
            ? PinViewMode.standard
            : PinViewMode.expanded;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        key: _sheet,
        initialChildSize: 0.2,
        maxChildSize: 0.9,
        minChildSize: 0,
        expand: true,
        snap: true,
        snapSizes: [60 / constraints.maxHeight, 0.2],
        controller: _controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    TabPageSelector(
                      controller: _tabController,
                    ),
                    SizedBox(
                      height: constraints.maxHeight,
                      child: PageView(
                        onPageChanged: onPinViewChanged,
                        controller: _pageViewController,
                        children: widget.selectedPin.pinsData
                            .map((pin) => PinView(
                                  data: pin,
                                  currentViewMode: currentPinViewMode,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

enum PinViewMode {
  collapsed,
  standard,
  expanded,
}

class PinView extends StatelessWidget {
  const PinView({
    super.key,
    required this.data,
    required this.currentViewMode,
  });

  final PinData data;
  final PinViewMode currentViewMode;

  Widget _getPinViewBasedOnHeight() {
    switch (currentViewMode) {
      case PinViewMode.collapsed:
        return Container();
      case PinViewMode.standard:
        return Container();
      case PinViewMode.expanded:
        return Container();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data.pinName),
            Text(data.pinStartDate),
            Text(data.pinEndDate),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data.tripName),
            Text(data.notes.length.toString()),
            Text(data.photos.length.toString())
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_rounded)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.delete_rounded)),
          ],
        ),
      ],
    );
  }
}
