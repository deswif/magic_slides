part of 'player_bloc.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class NextAsset extends PlayerState {}

class PlayerEnd extends PlayerState {}
