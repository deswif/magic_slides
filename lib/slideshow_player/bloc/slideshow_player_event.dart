part of 'slideshow_player_bloc.dart';

@immutable
abstract class SlideshowPlayerEvent {}

class SlideshowPlayerStarted extends SlideshowPlayerEvent {}

class SlideshowAssetSwitched extends SlideshowPlayerEvent {}
