part of 'slideshow_editor_bloc.dart';

@immutable
abstract class SlideshowEditorEvent {}

class AssetRemoved extends SlideshowEditorEvent {
  AssetRemoved(this.index);

  final int index;
}

class AutoNavigateChanged extends SlideshowEditorEvent {
  AutoNavigateChanged({required this.index, required this.auto});

  final int index;
  final bool auto;
}

class AutoNavigateDurationChanged extends SlideshowEditorEvent {
  AutoNavigateDurationChanged({required this.index, required this.duration});

  final int index;
  final int duration;
}

class AssetReordered extends SlideshowEditorEvent {
  AssetReordered(this.index, this.newIndex);

  final int index;
  final int newIndex;
}

class VideoGestured extends SlideshowEditorEvent {
  VideoGestured(this.index);

  final int index;
}

class NameChanged extends SlideshowEditorEvent {
  NameChanged({required this.name});

  final String name;
}
