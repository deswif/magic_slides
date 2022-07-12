import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'magic_tap_editor_event.dart';

part 'magic_tap_editor_state.dart';

class MagicTapEditorBloc
    extends Bloc<MagicTapEditorEvent, MagicTapEditorState> {
  MagicTapEditorBloc() : super(MagicTapEditorInitial()) {
    on<MagicTapEditorStarted>(_onStart);
    on<MagicTapPickBackgroundTapped>(_onPickBG);
    on<MagicTapBackgroundPicked>(_onBGPicked);
    on<MagicTapPickPNGTapped>(_onPickPNG);
    on<MagicTapPNGPicked>(_onPNGPicked);
    on<MagicTapAddPNGTapped>(_onAddPNG);
    on<MagicTapPNGRemoved>(_onRemoved);
    on<MagicTapEditorClosed>(_onMagicTapEditorClosed);
    on<NameChanged>(_onNameChanged);
    on<MagicTapPlayerStarted>(_onPlayerStarted);
  }

  late String _name;
  File? background;
  List<File?> pngList = [];

  void _onStart(
    MagicTapEditorStarted event,
    Emitter<MagicTapEditorState> emit,
  ) {
    pngList = [null, null];
    emit(NewList(background: background, pngs: pngList));
  }

  void _onPickBG(
    MagicTapPickBackgroundTapped event,
    Emitter<MagicTapEditorState> emit,
  ) {
    emit(PickBackground());
  }

  void _onBGPicked(
    MagicTapBackgroundPicked event,
    Emitter<MagicTapEditorState> emit,
  ) {
    if (event.background != null) {
      background = event.background;
    }
    emit(NewList(background: background, pngs: pngList));
  }

  void _onPickPNG(
    MagicTapPickPNGTapped event,
    Emitter<MagicTapEditorState> emit,
  ) {
    emit(PickPNG(index: event.index));
  }

  Future<void> _onPNGPicked(
    MagicTapPNGPicked event,
    Emitter<MagicTapEditorState> emit,
  ) async {
    final png = event.png;
    if (png != null) {
      pngList[event.index] = png;
    }
    emit(NewList(background: background, pngs: pngList));
  }

  void _onAddPNG(
    MagicTapAddPNGTapped event,
    Emitter<MagicTapEditorState> emit,
  ) {
    pngList.add(null);
    emit(NewList(background: background, pngs: pngList));
  }

  void _onRemoved(
    MagicTapPNGRemoved event,
    Emitter<MagicTapEditorState> emit,
  ) {
    pngList.removeAt(event.index);
    emit(NewList(background: background, pngs: pngList));
  }

  void _onMagicTapEditorClosed(
    MagicTapEditorClosed event,
    Emitter<MagicTapEditorState> emit,
  ) {
    emit(Close());
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<MagicTapEditorState> emit,
  ) {
    _name = event.name;
  }

  void _onPlayerStarted(
    MagicTapPlayerStarted event,
    Emitter<MagicTapEditorState> emit,
  ) {
    final result = <File>[];
    for (final png in pngList) {
      if (png != null) {
        result.add(png);
      }
    }
    emit(MagicTapPlayer(background: background!, pngs: result));
  }
}
