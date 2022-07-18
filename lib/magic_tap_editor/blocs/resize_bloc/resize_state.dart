part of 'resize_bloc.dart';

class ResizeState {
  ResizeState({required this.png, required this.isEnd, required this.isActive});

  final bool isActive;
  final bool isEnd;
  final Png png;

  ResizeState copyWith({
    bool? isActive,
    bool? isEnd,
    Png? png,
  }) {
    return ResizeState(
      isActive: isActive ?? this.isActive,
      isEnd: isEnd ?? this.isEnd,
      png: png ?? this.png,
    );
  }
}
