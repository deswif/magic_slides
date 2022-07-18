import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/app/app.dart';
import 'package:magic_slides/home/bloc/home_bloc.dart';
import 'package:magic_slides/home/widgets/widgets.dart';
import 'package:magic_slides/magic_tap_editor/view/view.dart';
import 'package:magic_slides/slideshow_editor/models/assets_model.dart';
import 'package:magic_slides/slideshow_editor/view/view.dart';
import 'package:magic_slides/theme/theme.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) async {
          if (state is HomeNewProject) {
            _showOptions(context);
          } else if (state is HomeAssetsPick) {
            await _showAssetsPicker(context);
          } else if (state is HomeSuccessAssetsPick) {
            final _models = <Assets>[];
            for (final asset in state.result) {
              if (asset.type == AssetType.image) {
                final file = await asset.file;
                _models.add(ImageModel(imageFile: file!));
              } else if (asset.type == AssetType.video) {
                final file = await asset.file;
                final _controller = VideoPlayerController.file(file!);
                await _controller.setVolume(0);
                await _controller.initialize();
                _models.add(VideoModel(controller: _controller));
              }
            }

            // ignore: use_build_context_synchronously
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (_) => SlideshowEditorPage(assets: _models),
              ),
            );
          } else if (state is MagicTapEditor) {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const MagicTapEditorPage(),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            children: const [LeadPart(), Buttons()],
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return const MagicBottomSheet(
          child: NewProjectDialog(),
        );
      },
    );
  }

  Future<void> _showAssetsPicker(BuildContext context) async {
    Navigator.pop(context);
    context.read<HomeBloc>().add(
          AssetsPicked(
            await AssetPicker.pickAssets(
              context,
              pickerConfig: const AssetPickerConfig(
                maxAssets: 20,
                pageSize: 90,
                themeColor: MagicColors.lightGrey,
                gridCount: 3,
              ),
            ),
          ),
        );
  }
}
