import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/magic_tap_editor/bloc/magic_tap_editor_bloc.dart';
import 'package:magic_slides/magic_tap_editor/widgets/widgets.dart';
import 'package:magic_slides/theme/theme.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MagicTapEditorPage extends StatelessWidget {
  const MagicTapEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MagicTapEditorBloc()..add(MagicTapEditorStarted()),
      child: const MagicTapEditorView(),
    );
  }
}

class MagicTapEditorView extends StatelessWidget {
  const MagicTapEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MagicTapEditorBloc, MagicTapEditorState>(
        listener: (context, state) async {
          if (state is PickPNG) {
            final assets = await AssetPicker.pickAssets(
              context,
              pickerConfig: const AssetPickerConfig(
                maxAssets: 1,
                pageSize: 90,
                requestType: RequestType.image,
                gridCount: 3,
                themeColor: MagicColors.lightGrey,
              ),
            );

            final png = await assets?[0].originFile;
            context
                .read<MagicTapEditorBloc>()
                .add(MagicTapPNGPicked(index: state.index, png: png));
          } else if (state is PickBackground) {
            final assets = await AssetPicker.pickAssets(
              context,
              pickerConfig: const AssetPickerConfig(
                maxAssets: 1,
                pageSize: 90,
                requestType: RequestType.image,
                gridCount: 3,
                themeColor: MagicColors.lightGrey,
              ),
            );
            final background = await assets?[0].originFile;
            context
                .read<MagicTapEditorBloc>()
                .add(MagicTapBackgroundPicked(background: background));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 27),
          child: BlocListener<MagicTapEditorBloc, MagicTapEditorState>(
            listener: (context, state) {
              if (state is Close) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const HomePage(),
                  ),
                );
              }
            },
            child: Column(
              children: [
                LeadPart(),
                const SizedBox(height: 50),
                Expanded(
                  child: BlocBuilder<MagicTapEditorBloc, MagicTapEditorState>(
                    builder: (context, state) => const AssetsList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
