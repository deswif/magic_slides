import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/slideshow_player/bloc/slideshow_player_bloc.dart';
import 'package:magic_slides/slideshow_player/models/assets_model.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SlideshowPlayerPage extends StatelessWidget {
  const SlideshowPlayerPage({super.key, required this.assets});

  final List<AssetEntity> assets;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SlideshowPlayerBloc(assets),
      child: const SlideshowPlayerView(),
    );
  }
}

class SlideshowPlayerView extends StatelessWidget {
  const SlideshowPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SlideshowPlayerBloc, SlideshowPlayerState>(
        builder: (context, state) {
          if (state is SlideshowNextAsset) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  context
                      .read<SlideshowPlayerBloc>()
                      .add(SlideshowAssetSwitched());
                },
                child: Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Center(
                        child: IndexedStack(
                          alignment: Alignment.center,
                          index:
                              context.read<SlideshowPlayerBloc>().currentIndex,
                          children: getWidgets(context),
                        ),
                      ),
                      Container(
                        height: 38,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is SlideshowPlayerEnd) {
            Future.delayed(Duration.zero, () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const HomePage(),
                ),
              );
            });
            return const SizedBox();
          } else if (state is SlideshowPlayerInitial) {
            context.read<SlideshowPlayerBloc>().add(SlideshowPlayerStarted());
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  List<Widget> getWidgets(BuildContext context) {
    final widgets = <Widget>[];
    final assets = context.read<SlideshowPlayerBloc>().models;

    for (final asset in assets) {
      if (asset is ImageModel) {
        widgets.add(
          Image.file(
            asset.imageFile,
          ),
        );
      } else if (asset is VideoModel) {
        widgets.add(
          AspectRatio(
            aspectRatio: asset.controller.value.aspectRatio,
            child: VideoPlayer(asset.controller),
          ),
        );
      }
    }

    return widgets;
  }
}
