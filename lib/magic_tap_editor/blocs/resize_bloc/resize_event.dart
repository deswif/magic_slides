part of 'resize_bloc.dart';

@immutable
abstract class ResizeEvent {}

class PNGMoved extends ResizeEvent {
  PNGMoved(this.x, this.y);

  final double x;
  final double y;
}

class PNGScaled extends ResizeEvent {
  PNGScaled(this.height, this.width);

  final double height;
  final double width;
}

class PNGGestured extends ResizeEvent {
  PNGGestured({required this.isActive});

  final bool isActive;
}

class PNGSavePressed extends ResizeEvent {}
