part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class NewProjectClicked extends HomeEvent {}

class ExistingProjectsClicked extends HomeEvent {}

class SlidesClicked extends HomeEvent {}

class MagicTapClicked extends HomeEvent {}

class AssetsPicked extends HomeEvent {
  AssetsPicked(this.result);

  final List<AssetEntity>? result;
}

class ImagePicked extends HomeEvent {}
