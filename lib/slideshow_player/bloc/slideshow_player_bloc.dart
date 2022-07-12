import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:magic_slides/slideshow_player/models/assets_model.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'slideshow_player_event.dart';

part 'slideshow_player_state.dart';

class SlideshowPlayerBloc
    extends Bloc<SlideshowPlayerEvent, SlideshowPlayerState> {
  SlideshowPlayerBloc(this.assets) : super(SlideshowPlayerInitial()) {
    on<SlideshowPlayerStarted>(_onPlayerStarted);
    on<SlideshowAssetSwitched>(_onAssetSwitched);
  }

  final List<AssetEntity> assets;
  List<Assets> models = [];
  int currentIndex = 0;

  Future<void> _onPlayerStarted(
    SlideshowPlayerStarted event,
    Emitter<SlideshowPlayerState> emit,
  ) async {
    final _models = <Assets>[];
    for (final asset in assets) {
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

    models = _models;
    await Future<void>.delayed(const Duration(seconds: 2));
    final firstAsset = models[0];
    if (firstAsset is VideoModel) {
      await firstAsset.controller.play();
    }
    emit(SlideshowNextAsset());
  }

  void _onAssetSwitched(
    SlideshowAssetSwitched event,
    Emitter<SlideshowPlayerState> emit,
  ) {
    currentIndex++;

    if (currentIndex == models.length) {
      emit(SlideshowPlayerEnd());
    } else {
      final model = models[currentIndex];
      if (model is VideoModel) {
        model.controller.play();
      }
      emit(SlideshowNextAsset());
    }
  }
}
