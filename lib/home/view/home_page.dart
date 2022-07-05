import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/app/app.dart';
import 'package:magic_slides/home/bloc/home_bloc.dart';
import 'package:magic_slides/home/widgets/widgets.dart';
import 'package:magic_slides/player/view/player_view.dart';
import 'package:magic_slides/theme/theme.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeNewProject) {
            _showOptions(context);
          } else if (state is HomeAssetsPick) {
            _showAssetsPicker(context);
          } else if (state is HomeSuccessAssetsPick) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (_) => PlayerPage(assets: state.result),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            children: const [LeadPart(), Buttons()],
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return const MagicBottomSheet(
          child: NewProjectDialog(),
        );
      },
    );
  }

  Future<void> _showAssetsPicker(BuildContext context) async {
    Navigator.pop(context);
    context.read<HomeBloc>().add(
          AssetsPicked(
            await AssetPicker.pickAssets(
              context,
              pickerConfig: const AssetPickerConfig(
                maxAssets: 20,
                pageSize: 90,
                themeColor: MagicColors.lightGrey,
                gridCount: 3,
              ),
            ),
          ),
        );
  }
}
