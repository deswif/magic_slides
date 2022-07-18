import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:magic_slides/magic_tap_editor/models/png_model.dart';
import 'package:meta/meta.dart';

part 'magic_tap_player_event.dart';

part 'magic_tap_player_state.dart';

class MagicTapPlayerBloc
    extends Bloc<MagicTapPlayerEvent, MagicTapPlayerState> {
  MagicTapPlayerBloc({
    required this.background,
    required this.pngs,
  }) : super(MagicTapPlayerInitial()) {
    on<MagicTapPlayerStarted>(_onPlayerStarted);
    on<MagicTapPNGSwitched>(_onPNGSwitched);
  }

  final File background;
  final List<Png> pngs;
  int currentIndex = 0;

  void _onPlayerStarted(
    MagicTapPlayerStarted event,
    Emitter<MagicTapPlayerState> emit,
  ) {
    emit(MagicTapNextPNG());
  }

  void _onPNGSwitched(
    MagicTapPNGSwitched event,
    Emitter<MagicTapPlayerState> emit,
  ) {
    currentIndex++;
    if (currentIndex == pngs.length) {
      emit(MagicTapPlayerEnd());
    } else {
      emit(MagicTapNextPNG());
    }
  }
}
