part of 'magic_tap_editor_bloc.dart';

@immutable
abstract class MagicTapEditorEvent {}

class MagicTapEditorClosed extends MagicTapEditorEvent {}

class NameChanged extends MagicTapEditorEvent {
  NameChanged(this.name);

  final String name;
}
