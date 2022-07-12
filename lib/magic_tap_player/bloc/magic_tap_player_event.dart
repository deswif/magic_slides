part of 'magic_tap_player_bloc.dart';

@immutable
abstract class MagicTapPlayerEvent {}

class MagicTapPlayerStarted extends MagicTapPlayerEvent {}

class MagicTapPNGSwitched extends MagicTapPlayerEvent {}
