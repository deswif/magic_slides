part of 'magic_tap_editor_bloc.dart';

@immutable
abstract class MagicTapEditorState {}

class MagicTapEditorInitial extends MagicTapEditorState {}

class Close extends MagicTapEditorState {}

class PickPNG extends MagicTapEditorState {
  PickPNG({required this.index});

  final int index;
}

class PickBackground extends MagicTapEditorState {}

class NewList extends MagicTapEditorState {
  NewList({required this.background, required this.pngs});

  final File? background;
  final List<File?> pngs;
}
