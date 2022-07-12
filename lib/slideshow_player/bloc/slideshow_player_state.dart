part of 'slideshow_player_bloc.dart';

@immutable
abstract class SlideshowPlayerState {}

class SlideshowPlayerInitial extends SlideshowPlayerState {}

class SlideshowNextAsset extends SlideshowPlayerState {}

class SlideshowPlayerEnd extends SlideshowPlayerState {}
