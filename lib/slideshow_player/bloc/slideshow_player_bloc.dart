import 'dart:async';

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
  int currentIndex = -1;

  Future<void> _onPlayerStarted(
    SlideshowPlayerStarted event,
    Emitter<SlideshowPlayerState> emit,
  ) async {
    add(SlideshowAssetSwitched());
  }

  Future<void> _onAssetSwitched(
    SlideshowAssetSwitched event,
    Emitter<SlideshowPlayerState> emit,
  ) async {
    currentIndex++;
    if (currentIndex == assets.length) {
      emit(SlideshowPlayerEnd());
    } else {
      final model = assets[currentIndex];
      if (model is VideoModel) {
        await model.controller.play();
        if (model.autoNavigate) {
          Future<void>.delayed(model.controller.value.duration, () {
            if (currentIndex == assets.indexOf(model)) {
              add(SlideshowAssetSwitched());
            }
          });
        }
      } else if (model is ImageModel) {
        if (model.autoNavigate) {
          Future<void>.delayed(Duration(seconds: model.duration), () {
            if (currentIndex == assets.indexOf(model)) {
              add(SlideshowAssetSwitched());
            }
          });
        }
      }
      emit(SlideshowNextAsset());
    }
  }
}
