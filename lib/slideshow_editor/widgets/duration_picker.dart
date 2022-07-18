import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/slideshow_editor/bloc/slideshow_editor_bloc.dart';
import 'package:magic_slides/slideshow_editor/models/assets_model.dart';

class DurationPicker extends StatelessWidget {
  const DurationPicker({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController:
          FixedExtentScrollController(initialItem: _getInitialItem(context)),
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32,
      onSelectedItemChanged: (int value) {
        context.read<SlideshowEditorBloc>().add(
              AutoNavigateDurationChanged(index: index, duration: value + 1),
            );
      },
      children: List<Widget>.generate(
        20,
        (index) => Center(
          child: Text(
            '${index + 1} sec',
          ),
        ),
      ),
    );
  }

  int _getInitialItem(BuildContext context) {
    final image =
        context.read<SlideshowEditorBloc>().state.assets[index] as ImageModel;
    return image.duration - 1;
  }
}
