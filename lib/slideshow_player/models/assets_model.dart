import 'dart:io';

import 'package:video_player/video_player.dart';

abstract class Assets {}

class ImageModel extends Assets {
  ImageModel({required this.imageFile});

  final File imageFile;
}

class VideoModel extends Assets {
  VideoModel({required this.controller});
  final VideoPlayerController controller;
}
