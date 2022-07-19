import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_slides/magic_tap_editor/magic_tap_editor.dart';
import 'package:magic_slides/theme/theme.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AssetsList extends StatelessWidget {
  const AssetsList({super.key});

  static const maxPngs = 20;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagicTapEditorBloc, MagicTapEditorState>(
      builder: (context, state) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: CustomCard(
                      child: Builder(
                        builder: (context) {
                          final background = state.background;
                          if (background != null) {
                            return Image.file(background);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    height: 66,
                    width: 166,
                    child: ElevatedButton(
                      onPressed: () {
                        _pickBackground(context);
                      },
                      child: Text(
                        'Pick background',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Builder(
              builder: (context) => Column(
                children: _widgets(context, state.pngs),
              ),
            ),
            Builder(
              builder: (context) {
                if (state.pngs.length < maxPngs) {
                  return Align(
                    alignment: const Alignment(-0.65, 0),
                    child: IconButton(
                      splashRadius: 30,
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset('assets/icons/new_png.svg'),
                      onPressed: () {
                        context
                            .read<MagicTapEditorBloc>()
                            .add(MagicTapAddPNGTapped());
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _pickBackground(BuildContext context) async {
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
    // ignore: use_build_context_synchronously
    context
        .read<MagicTapEditorBloc>()
        .add(MagicTapBackgroundPicked(background: background));
  }

  List<Widget> _widgets(BuildContext context, List<Png?> pngs) {
    final widgets = <Widget>[];

    for (var i = 0; i < pngs.length; i++) {
      widgets.add(
        PNGCard(
          png: pngs[i],
          index: i,
        ),
      );
    }

    return widgets;
  }
}
