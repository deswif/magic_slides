import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/slideshow_player/bloc/player_bloc.dart';
import 'package:magic_slides/slideshow_player/models/assets_model.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key, required this.assets});

  final List<AssetEntity> assets;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBloc(assets),
      child: const PlayerView(),
    );
  }
}

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state is NextAsset) {
            print('VIEW asset ${context.read<PlayerBloc>().currentIndex}');
            return Center(
              child: GestureDetector(
                onTap: () {
                  context.read<PlayerBloc>().add(AssetSwitched());
                },
                child: Stack(
                  children: [
                    IndexedStack(
                      alignment: Alignment.center,
                      index: context.read<PlayerBloc>().currentIndex,
                      children: getWidgets(context),
                    ),
                    Container(
                      height: 38,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            );
          } else if (state is PlayerEnd) {
            print('VIEW slideshow_player ended');
            Future.delayed(Duration.zero, () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const HomePage(),
                ),
              );
            });
            return const SizedBox();
          } else if (state is PlayerInitial) {
            print('VIEW Player started');
            context.read<PlayerBloc>().add(PlayerStarted());
            return const Center(child: CupertinoActivityIndicator(
              color: Colors.white,
            ));
          } else {
            print('nothing');
            return const SizedBox();
          }
        },
      ),
    );
  }

  List<Widget> getWidgets(BuildContext context) {
    print('VIEW getting widgets');

    final widgets = <Widget>[];
    final assets = context.read<PlayerBloc>().models;

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
