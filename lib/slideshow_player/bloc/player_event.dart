part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {}

class PlayerStarted extends PlayerEvent {}

class AssetSwitched extends PlayerEvent {}
