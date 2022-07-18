part of 'magic_tap_editor_bloc.dart';

class MagicTapEditorState {
  MagicTapEditorState({
    this.background,
    required this.pngs,
    this.name,
  });

  final File? background;
  final List<Png?> pngs;
  final String? name;

  MagicTapEditorState copyWith({
    File? background,
    List<Png?>? pngs,
    String? name,
  }) {
    return MagicTapEditorState(
      background: background ?? this.background,
      pngs: pngs ?? this.pngs,
      name: name ?? this.name,
    );
  }
}
