import 'dart:io';

class Png {
  Png({
    required this.height,
    required this.width,
    required this.x,
    required this.y,
    required this.file,
  });

  final double height;
  final double width;
  final double x;
  final double y;
  final File file;

  Png copyWith({
    double? height,
    double? width,
    double? x,
    double? y,
    File? file,
  }) {
    return Png(
      height: height ?? this.height,
      width: width ?? this.width,
      x: x ?? this.x,
      y: y ?? this.y,
      file: file ?? this.file,
    );
  }
}
