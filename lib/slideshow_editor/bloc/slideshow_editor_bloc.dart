import 'package:bloc/bloc.dart';
import 'package:magic_slides/slideshow_editor/models/assets_model.dart';
import 'package:meta/meta.dart';

part 'slideshow_editor_event.dart';

part 'slideshow_editor_state.dart';

class SlideshowEditorBloc
    extends Bloc<SlideshowEditorEvent, SlideshowEditorState> {
  SlideshowEditorBloc(List<Assets> assets)
      : super(SlideshowEditorState(assets: assets)) {
    on<AssetRemoved>(_onAssetRemoved);
    on<AutoNavigateChanged>(_onAutoNavigateChanged);
    on<AutoNavigateDurationChanged>(_onAutoNavigateDurationChanged);
    on<AssetReordered>(_onAssetReordered);
    on<VideoGestured>(_onVideoGestured);
    on<NameChanged>(_onNameChanged);
  }

  void _onAssetRemoved(
    AssetRemoved event,
    Emitter<SlideshowEditorState> emit,
  ) {
    final list = state.assets..removeAt(event.index);
    emit(state.copyWith(assets: list));
  }

  void _onAutoNavigateChanged(
    AutoNavigateChanged event,
    Emitter<SlideshowEditorState> emit,
  ) {
    final list = state.assets..[event.index].autoNavigate = event.auto;
    emit(state.copyWith(assets: list));
  }

  void _onAutoNavigateDurationChanged(
    AutoNavigateDurationChanged event,
    Emitter<SlideshowEditorState> emit,
  ) {
    final list = state.assets;
    final asset = list[event.index];
    if (asset is ImageModel) {
      list[event.index] = asset.copyWith(duration: event.duration);
    }
    emit(state.copyWith(assets: list));
  }

  void _onAssetReordered(
    AssetReordered event,
    Emitter<SlideshowEditorState> emit,
  ) {
    // ignore: prefer_final_locals
    var list = state.assets;
    final asset = list.removeAt(event.index);
    list.insert(event.newIndex, asset);
    emit(state.copyWith(assets: list));
  }

  Future<void> _onVideoGestured(
    VideoGestured event,
    Emitter<SlideshowEditorState> emit,
  ) async {
    final list = state.assets;
    final video = list[event.index] as VideoModel;
    await video.controller.play();
    // list[event.index] = video;
    // emit(state.copyWith(assets: list));
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<SlideshowEditorState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }
}
