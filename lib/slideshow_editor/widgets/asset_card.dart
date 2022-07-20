import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/slideshow_editor/slideshow_editor.dart';
import 'package:magic_slides/theme/theme.dart';
import 'package:video_player/video_player.dart';

class AssetCard extends StatelessWidget {
  const AssetCard({super.key, required this.asset, required this.index});

  final Assets asset;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(top: 40, right: 18, left: 18, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(4, 4),
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Center(
                child: Builder(
                  builder: (context) {
                    final asset = this.asset;
                    if (asset is ImageModel) {
                      return Image.file(asset.imageFile);
                    } else if (asset is VideoModel) {
                      return GestureDetector(
                        onTap: () => context
                            .read<SlideshowEditorBloc>()
                            .add(VideoGestured(index)),
                        child: AspectRatio(
                          aspectRatio: asset.controller.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(asset.controller),
                              const Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5, right: 5),
                                  child: Icon(
                                    Icons.play_arrow_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 31),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Auto navigate',
                style: Theme.of(context).textTheme.settings,
              ),
              CupertinoSwitch(
                value: context
                    .read<SlideshowEditorBloc>()
                    .state
                    .assets[index]
                    .autoNavigate,
                onChanged: (value) {
                  context
                      .read<SlideshowEditorBloc>()
                      .add(AutoNavigateChanged(index: index, auto: value));
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          Builder(
            builder: (context) {
              final asset = this.asset;
              if (asset is ImageModel) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration',
                      style: asset.autoNavigate
                          ? Theme.of(context).textTheme.settings
                          : Theme.of(context).textTheme.inactiveSettings,
                    ),
                    SizedBox(
                      height: 45,
                      child: Builder(
                        builder: (context) {
                          if (asset.autoNavigate) {
                            return CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (_) => FractionallySizedBox(
                                    heightFactor: 0.3,
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 6),
                                      margin: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      color: MagicColors.pink,
                                      child: SafeArea(
                                        top: false,
                                        child: BlocProvider.value(
                                          value: context
                                              .read<SlideshowEditorBloc>(),
                                          child: DurationPicker(index: index),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Material(
                                textStyle: const TextStyle(
                                  fontSize: 25,
                                  color: MagicColors.pink,
                                ),
                                child: Text(
                                  '${asset.duration} sec',
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Material(
                                textStyle: TextStyle(
                                  fontSize: 25,
                                  color: MagicColors.pink.withOpacity(0.4),
                                ),
                                child: Text(
                                  '${asset.duration} sec',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox(
                  height: 45,
                );
              }
            },
          ),
          const SizedBox(
            height: 23,
          ),
          SizedBox(
            height: 44,
            width: 124,
            child: ElevatedButton(
              onPressed: () {
                context.read<SlideshowEditorBloc>().add(AssetRemoved(index));
              },
              child: const Text('Remove'),
            ),
          )
        ],
      ),
    );
  }
}
