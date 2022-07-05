part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeNewProject extends HomeState {}

class HomeExistingProjects extends HomeState {}

class HomeAssetsPick extends HomeState {}

class HomeSuccessAssetsPick extends HomeState {
  HomeSuccessAssetsPick(this.result);

  final List<AssetEntity> result;
}

class HomeImagePick extends HomeState {}
