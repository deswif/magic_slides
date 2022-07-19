import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_slides/app/widgets/error_dialog.dart';
import 'package:magic_slides/slideshow_editor/models/assets_model.dart';
import 'package:magic_slides/slideshow_editor/slideshow_editor.dart';
import 'package:magic_slides/theme/theme.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class BottomAddButton extends StatelessWidget {
  const BottomAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.read<SlideshowEditorBloc>().state.assets.length < 20) {
          _showAssetsPicker(context);
        } else {
          showDialog<void>(
            context: context,
            builder: (context) {
              return const ErrorDialog(
                message: 'The number of assets must be not greater than 20',
              );
            },
          );
        }
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: MagicColors.pink,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SvgPicture.asset(
              'assets/icons/new_png.svg',
              color: Colors.black,
              height: 50,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAssetsPicker(BuildContext context) async {
    final entity = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        pageSize: 90,
        themeColor: MagicColors.lightGrey,
        gridCount: 3,
      ),
    );

    if (entity != null) {
      final file = await entity[0].file;

      if (entity[0].type == AssetType.image) {
        // ignore: use_build_context_synchronously
        context
            .read<SlideshowEditorBloc>()
            .add(AssetAdded(ImageModel(imageFile: file!)));
      } else if (entity[0].type == AssetType.video) {
        final controller = VideoPlayerController.file(file!);
        await controller.initialize();
        await controller.setVolume(0);
        // ignore: use_build_context_synchronously
        context.read<SlideshowEditorBloc>().add(
              AssetAdded(
                VideoModel(controller: controller),
              ),
            );
      }
    }
  }
}
