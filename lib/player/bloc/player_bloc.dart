import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:magic_slides/player/models/assets_model.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc(this.assets) : super(PlayerInitial()) {
    on<PlayerStarted>(_onPlayerStarted);
    on<AssetSwitched>(_onAssetSwitched);
  }

  final List<AssetEntity> assets;
  List<Assets> models = [];
  int currentIndex = 0;

  Future<void> _onPlayerStarted(
    PlayerStarted event,
    Emitter<PlayerState> emit,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    print('player Started');
    final _models = <Assets>[];
    print(_models);
    for (final asset in assets) {
      if (asset.type == AssetType.image) {
        final file = await asset.file;
        _models.add(ImageModel(imageFile: file!));
        print('image added');
      } else if (asset.type == AssetType.video) {
        final file = await asset.file;
        final _controller = VideoPlayerController.file(file!);
        await _controller.initialize();
        _models.add(VideoModel(controller: _controller));
        print('video added');
      }
    }

    models = _models;
    print('first asset');
    emit(NextAsset());
  }

  void _onAssetSwitched(AssetSwitched event, Emitter<PlayerState> emit) {
    currentIndex++;

    if (currentIndex == models.length) {
      print('player ended');
      emit(PlayerEnd());
    } else {
      final model = models[currentIndex];
      if (model is VideoModel) {
        print('video started');
        model.controller.play();
      }
      print('new asset $currentIndex');
      emit(NextAsset());
    }
  }
}
