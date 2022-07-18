import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:magic_slides/slideshow_editor/models/assets_model.dart';

part 'slideshow_player_event.dart';

part 'slideshow_player_state.dart';

class SlideshowPlayerBloc
    extends Bloc<SlideshowPlayerEvent, SlideshowPlayerState> {
  SlideshowPlayerBloc(this.assets) : super(SlideshowPlayerInitial()) {
    on<SlideshowPlayerStarted>(_onPlayerStarted);
    on<SlideshowAssetSwitched>(_onAssetSwitched);
  }

  final List<Assets> assets;
  int currentIndex = 0;

  Future<void> _onPlayerStarted(
    SlideshowPlayerStarted event,
    Emitter<SlideshowPlayerState> emit,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final firstAsset = assets[0];
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

    if (currentIndex == assets.length) {
      emit(SlideshowPlayerEnd());
    } else {
      final model = assets[currentIndex];
      if (model is VideoModel) {
        model.controller.play();
      }
      emit(SlideshowNextAsset());
    }
  }
}
