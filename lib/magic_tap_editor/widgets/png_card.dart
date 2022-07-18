import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/magic_tap_editor/magic_tap_editor.dart';
import 'package:magic_slides/theme/theme.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PNGCard extends StatelessWidget {
  const PNGCard({
    super.key,
    required this.index,
    required this.png,
  });

  final Png? png;
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
          GestureDetector(
            onTap: () {
              final png = this.png;
              if (png != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<MagicTapEditorBloc>(),
                        child: ResizePage(
                          index: index,
                        ),
                      );
                    },
                  ),
                );
              }
            },
            child: CustomCard(
              child: Builder(
                builder: (context) {
                  final png = this.png;
                  if (png != null) {
                    return Image.file(png.file);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 66,
            width: 136,
            child: ElevatedButton(
              onPressed: () {
                _pickPNG(context);
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

  Future<void> _pickPNG(BuildContext context) async {
    final assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        pageSize: 90,
        requestType: RequestType.image,
        gridCount: 3,
        themeColor: MagicColors.lightGrey,
      ),
    );

    final file = await assets?[0].originFile;
    Png? png;
    if (file != null) {
      png = await _createPng(context, file);
    }
    context
        .read<MagicTapEditorBloc>()
        .add(MagicTapPNGPicked(index: index, png: png));
  }

  Future<Png> _createPng(
    BuildContext context,
    File file,
  ) async {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double height;
    double width;
    final x = screenWidth / 2;
    final y = screenHeight / 2;

    final bytes = await file.readAsBytes();
    final buffer = await ImmutableBuffer.fromUint8List(bytes);
    final descriptor = await ImageDescriptor.encoded(buffer);
    height = descriptor.height.toDouble();
    width = descriptor.width.toDouble();

    final cofHeight = screenHeight / height;
    final cofWidth = screenWidth / width;

    if (cofHeight < 1 || cofWidth < 1) {
      if (cofHeight < cofWidth) {
        height *= cofHeight;
        width *= cofHeight;
      } else {
        height *= cofWidth;
        width *= cofWidth;
      }
    }

    return Png(
      file: file,
      height: height,
      width: width,
      x: x,
      y: y,
    );
  }
}
