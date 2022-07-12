import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/magic_tap_editor/bloc/magic_tap_editor_bloc.dart';
import 'package:magic_slides/magic_tap_editor/widgets/widgets.dart';
import 'package:magic_slides/theme/theme.dart';

class PNGCard extends StatelessWidget {
  const PNGCard({
    super.key,
    required this.index,
    required this.png,
  });

  final File? png;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              (index + 1).toString(),
              style: Theme.of(context).textTheme.title,
            ),
          ),
          CustomCard(
            child: Builder(
              builder: (context) {
                final png = this.png;
                if (png != null) {
                  return Image.file(png);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          SizedBox(
            height: 66,
            width: 136,
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<MagicTapEditorBloc>()
                    .add(MagicTapPickPNGTapped(index: index));
              },
              child: Text(
                'Pick PNG',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<MagicTapEditorBloc>()
                    .add(MagicTapPNGRemoved(index: index));
              },
              child: const Text('-'),
            ),
          )
        ],
      ),
    );
  }
}
