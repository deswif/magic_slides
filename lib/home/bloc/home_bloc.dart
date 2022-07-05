import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NewProjectClicked>(_onNewProjectClicked);
    on<ExistingProjectsClicked>(_onExistingProjectsClicked);
    on<SlidesClicked>(_onSlidesClicked);
    on<MagicTapClicked>(_onMagicTapClicked);
    on<AssetsPicked>(_onAssetsPicked);
    on<ImagePicked>(_onImagePicked);
  }

  void _onNewProjectClicked(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeNewProject());
  }

  void _onExistingProjectsClicked(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeExistingProjects());
  }

  void _onSlidesClicked(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeAssetsPick());
  }

  void _onMagicTapClicked(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeImagePick());
  }

  void _onAssetsPicked(AssetsPicked event, Emitter<HomeState> emit) {
    if (event.result != null) {
      emit(HomeSuccessAssetsPick(event.result!));
    }
  }

  void _onImagePicked(HomeEvent event, Emitter<HomeState> emit) {}
}
