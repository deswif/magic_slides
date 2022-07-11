import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'magic_tap_editor_event.dart';

part 'magic_tap_editor_state.dart';

class MagicTapEditorBloc
    extends Bloc<MagicTapEditorEvent, MagicTapEditorState> {
  MagicTapEditorBloc() : super(MagicTapEditorInitial()) {
    on<MagicTapEditorClosed>(_onMagicTapEditorClosed);
    on<NameChanged>(_onNameChanged);
  }

  late String _name;

  void _onMagicTapEditorClosed(
    MagicTapEditorClosed event,
    Emitter<MagicTapEditorState> emit,
  ) {
    emit(Close());
  }

  void _onNameChanged(
      NameChanged event,
      Emitter<MagicTapEditorState> emit,
      ) {
    _name = event.name;
    print(_name);
  }
}
