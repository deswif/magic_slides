import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/slideshow_editor/models/assets_model.dart';
import 'package:magic_slides/slideshow_editor/slideshow_editor.dart';

class AssetsList extends StatelessWidget {
  const AssetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SlideshowEditorBloc, SlideshowEditorState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            shadowColor: Colors.transparent,
            canvasColor: Colors.transparent,
          ),
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            scrollDirection: Axis.horizontal,
            children: _getWidgets(
              context,
              context.read<SlideshowEditorBloc>().state.assets,
            ),
            onReorder: (oldIndex, newIndex) {
              newIndex -= 1;
              print('$oldIndex $newIndex');
              context
                  .read<SlideshowEditorBloc>()
                  .add(AssetReordered(oldIndex, newIndex));
            },
          ),
        );
      },
    );
  }

  List<Widget> _getWidgets(BuildContext context, List<Assets> assets) {
    final widgets = <Widget>[];

    for (var i = 0; i < assets.length; i++) {
      widgets.add(
        BlocProvider.value(
          key: ValueKey<int>(i),
          value: context.read<SlideshowEditorBloc>(),
          child: AssetCard(
            asset: assets[i],
            index: i,
          ),
        ),
      );
    }

    return widgets;
  }
}
