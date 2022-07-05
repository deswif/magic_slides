import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/player/bloc/player_bloc.dart';
import 'package:magic_slides/player/models/assets_model.dart';
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
      body: Center(
        child: BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            if (state is NextAsset) {
              print('VIEW asset ${context.read<PlayerBloc>().currentIndex}');
              return GestureDetector(
                onTap: () {
                  context.read<PlayerBloc>().add(AssetSwitched());
                },
                child: IndexedStack(
                  index: context.read<PlayerBloc>().currentIndex,
                  children: getWidgets(context),
                ),
              );
            } else if (state is PlayerEnd) {
              print('VIEW player ended');
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
              return const CircularProgressIndicator();
            } else {
              print('nothing');
              return const SizedBox();
            }
          },
        ),
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
          Image.file(asset.imageFile),
        );
      } else if (asset is VideoModel) {
        widgets.add(
          VideoPlayer(asset.controller),
        );
      }
    }

    return widgets;
  }
}
