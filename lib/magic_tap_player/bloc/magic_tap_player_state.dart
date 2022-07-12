part of 'magic_tap_player_bloc.dart';

@immutable
abstract class MagicTapPlayerState {}

class MagicTapPlayerInitial extends MagicTapPlayerState {}

class MagicTapNextPNG extends MagicTapPlayerState {}

class MagicTapPlayerEnd extends MagicTapPlayerState {}
