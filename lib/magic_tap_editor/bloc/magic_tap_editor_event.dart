part of 'magic_tap_editor_bloc.dart';

@immutable
abstract class MagicTapEditorEvent {}

class MagicTapEditorStarted extends MagicTapEditorEvent {}

class MagicTapAddPNGTapped extends MagicTapEditorEvent {}

class MagicTapPNGRemoved extends MagicTapEditorEvent {
  MagicTapPNGRemoved({required this.index});

  final int index;
}

class MagicTapPickBackgroundTapped extends MagicTapEditorEvent {}

class MagicTapBackgroundPicked extends MagicTapEditorEvent {
  MagicTapBackgroundPicked({this.background});

  final File? background;
}

class MagicTapPickPNGTapped extends MagicTapEditorEvent {
  MagicTapPickPNGTapped({required this.index});

  final int index;
}

class MagicTapPNGPicked extends MagicTapEditorEvent {
  MagicTapPNGPicked({required this.index, this.png});

  final int index;
  final File? png;
}

class MagicTapEditorClosed extends MagicTapEditorEvent {}

class NameChanged extends MagicTapEditorEvent {
  NameChanged({required this.name});

  final String name;
}

class MagicTapPlayerStarted extends MagicTapEditorEvent {}
