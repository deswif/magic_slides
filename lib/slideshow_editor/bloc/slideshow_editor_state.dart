part of 'slideshow_editor_bloc.dart';

class SlideshowEditorState {
  SlideshowEditorState({required this.assets, this.name});

  final List<Assets> assets;
  final String? name;

  SlideshowEditorState copyWith({
    List<Assets>? assets,
    String? name,
  }) {
    return SlideshowEditorState(
      assets: assets ?? this.assets,
      name: name ?? this.name,
    );
  }
}
