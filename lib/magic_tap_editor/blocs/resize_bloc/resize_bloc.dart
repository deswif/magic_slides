import 'package:bloc/bloc.dart';
import 'package:magic_slides/magic_tap_editor/blocs/editor_bloc/magic_tap_editor_bloc.dart';
import 'package:magic_slides/magic_tap_editor/models/png_model.dart';
import 'package:meta/meta.dart';

part 'resize_event.dart';

part 'resize_state.dart';

class ResizeBloc extends Bloc<ResizeEvent, ResizeState> {
  ResizeBloc({required this.editorBloc, required this.index})
      : super(
          ResizeState(
            png: editorBloc.state.pngs[index]!,
            isEnd: false,
            isActive: false,
          ),
        ) {
    on<PNGGestured>(_onPNGGestured);
    on<PNGMoved>(_onPNGMoved);
    on<PNGScaled>(_onPNGScaled);
    on<PNGSavePressed>(_onPNGSavePressed);
  }

  final MagicTapEditorBloc editorBloc;
  final int index;

  void _onPNGGestured(
    PNGGestured event,
    Emitter<ResizeState> emit,
  ) {
    emit(
      state.copyWith(
        isActive: event.isActive,
      ),
    );
  }

  void _onPNGMoved(
    PNGMoved event,
    Emitter<ResizeState> emit,
  ) {
    if (state.isEnd) return;

    emit(
      state.copyWith(
        png: state.png.copyWith(
          x: event.x,
          y: event.y,
        ),
      ),
    );
  }

  Future<void> _onPNGScaled(
    PNGScaled event,
    Emitter<ResizeState> emit,
  ) async {
    emit(
      state.copyWith(
        isEnd: true,
        png: state.png.copyWith(
          height: event.height,
          width: event.width,
        ),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(isEnd: false));
  }

  void _onPNGSavePressed(
    PNGSavePressed event,
    Emitter<ResizeState> emit,
  ) {
    editorBloc.state.pngs[index] = state.png;
  }
}
