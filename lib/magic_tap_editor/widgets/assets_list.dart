import 'package:flutter/material.dart';
import 'package:magic_slides/magic_tap_editor/widgets/png_card.dart';

class PNGList extends StatelessWidget {
  const PNGList({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      child: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {},
        children: _widgets(context),
      ),
    );
  }

  List<Widget> _widgets(BuildContext context) {
    final list = <Widget>[];
    for (var i = 0; i < 3; i++) {
      list.add(
        PNGCard(
          index: i + 1,
          key: ValueKey(i),
        ),
      );
    }
    return list;
  }
}
