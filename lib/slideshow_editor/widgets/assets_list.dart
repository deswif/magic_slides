import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: state.assets.length,
            itemBuilder: (context, i) {
              return BlocProvider.value(
                key: ValueKey(state.assets[i]),
                value: context.read<SlideshowEditorBloc>(),
                child: AssetCard(
                  asset: state.assets[i],
                  index: i,
                ),
              );
            },
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;

              context
                  .read<SlideshowEditorBloc>()
                  .add(AssetReordered(oldIndex, newIndex));
            },
          ),
        );
      },
    );
  }
}
