import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:magic_slides/magic_tap_editor/models/png_model.dart';
import 'package:meta/meta.dart';

part 'magic_tap_editor_event.dart';

part 'magic_tap_editor_state.dart';

class MagicTapEditorBloc
    extends Bloc<MagicTapEditorEvent, MagicTapEditorState> {
  MagicTapEditorBloc() : super(MagicTapEditorState(pngs: [null, null])) {
    on<MagicTapBackgroundPicked>(_onBGPicked);
    on<MagicTapPNGPicked>(_onPNGPicked);
    on<MagicTapPNGChanged>(_onPNGChanged);
    on<MagicTapAddPNGTapped>(_onAddPNG);
    on<MagicTapPNGRemoved>(_onRemoved);
    on<NameChanged>(_onNameChanged);
  }

  void _onBGPicked(
    MagicTapBackgroundPicked event,
    Emitter<MagicTapEditorState> emit,
  ) {
    if (event.background != null) {
      emit(state.copyWith(background: event.background));
    }
  }

  Future<void> _onPNGPicked(
    MagicTapPNGPicked event,
    Emitter<MagicTapEditorState> emit,
  ) async {
    final png = event.png;
    if (png != null) {
      final pngs = state.pngs;
      pngs[event.index] = png;
      emit(state.copyWith(pngs: pngs));
    }
  }

  void _onPNGChanged(
    MagicTapPNGChanged event,
    Emitter<MagicTapEditorState> emit,
  ) {
    final pngs = state.pngs;
    pngs[event.index] = event.png;
    emit(state.copyWith(pngs: pngs));
  }

  void _onAddPNG(
    MagicTapAddPNGTapped event,
    Emitter<MagicTapEditorState> emit,
  ) {
    final pngs = state.pngs..add(null);
    emit(state.copyWith(pngs: pngs));
  }

  void _onRemoved(
    MagicTapPNGRemoved event,
    Emitter<MagicTapEditorState> emit,
  ) {
    final pngs = state.pngs..removeAt(event.index);
    emit(state.copyWith(pngs: pngs));
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<MagicTapEditorState> emit,
  ) {
    state.copyWith(name: event.name);
  }
}
