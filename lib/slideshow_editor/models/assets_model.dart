import 'dart:io';

import 'package:video_player/video_player.dart';

abstract class Assets {
  Assets({this.autoNavigate = false});

  bool autoNavigate;
}

class ImageModel extends Assets {
  ImageModel({
    super.autoNavigate,
    required this.imageFile,
    this.duration = 3,
  });

  final File imageFile;
  final int duration;

  ImageModel copyWith({
    int? duration,
  }) =>
      ImageModel(
        autoNavigate: autoNavigate,
        imageFile: imageFile,
        duration: duration ?? this.duration,
      );
}

class VideoModel extends Assets {
  VideoModel({required this.controller});

  final VideoPlayerController controller;
}
