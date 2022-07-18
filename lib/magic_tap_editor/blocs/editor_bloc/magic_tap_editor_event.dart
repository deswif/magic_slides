part of 'magic_tap_editor_bloc.dart';

@immutable
abstract class MagicTapEditorEvent {}

class MagicTapAddPNGTapped extends MagicTapEditorEvent {}

class MagicTapPNGRemoved extends MagicTapEditorEvent {
  MagicTapPNGRemoved({required this.index});

  final int index;
}

class MagicTapBackgroundPicked extends MagicTapEditorEvent {
  MagicTapBackgroundPicked({this.background});

  final File? background;
}

class MagicTapPNGPicked extends MagicTapEditorEvent {
  MagicTapPNGPicked({required this.index, this.png});

  final int index;
  final Png? png;
}

class MagicTapPNGChanged extends MagicTapEditorEvent {
  MagicTapPNGChanged({
    required this.png,
    required this.index,
  });

  final int index;
  final Png png;
}

class NameChanged extends MagicTapEditorEvent {
  NameChanged({required this.name});

  final String name;
}
