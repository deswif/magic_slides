import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_slides/app/widgets/error_dialog.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/slideshow_editor/slideshow_editor.dart';
import 'package:magic_slides/slideshow_player/view/player_view.dart';
import 'package:magic_slides/theme/theme.dart';

class LeadPart extends StatelessWidget {
  LeadPart({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const errorStyle = TextStyle(
      color: Colors.red,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    const hintStyle = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.3),
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      fontSize: 15,
    );

    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide.none,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            splashRadius: 20,
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const HomePage(),
              ),
            ),
            icon: SvgPicture.asset('assets/icons/cross.svg'),
          ),
          SizedBox(
            height: 37,
            width: 158,
            child: TextFormField(
              controller: _controller,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.input,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                filled: true,
                fillColor: Theme.of(context).colorScheme.card,
                border: border,
                hintText: 'Type name',
                hintStyle: hintStyle,
                errorStyle: errorStyle,
                hintMaxLines: 1,
              ),
            ),
          ),
          IconButton(
            splashRadius: 20,
            padding: EdgeInsets.zero,
            onPressed: () async {
              if (context.read<SlideshowEditorBloc>().state.assets.isEmpty) {
                await showDialog<void>(
                  context: context,
                  builder: (context) {
                    return const ErrorDialog(
                      message: 'There must be at least 1 asset',
                    );
                  },
                );
              } else if (_controller.text.trim() == '') {
                await showDialog<void>(
                  context: context,
                  builder: (context) {
                    return const ErrorDialog(message: "Name can't be empty");
                  },
                );
              } else {
                context.read<SlideshowEditorBloc>().add(
                      NameChanged(name: _controller.text.trim()),
                    );
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) {
                      final assets = <Assets>[];
                      for (final asset
                          in context.read<SlideshowEditorBloc>().state.assets) {
                        if (asset is VideoModel) {
                          asset.controller.pause();
                          asset.controller.seekTo(Duration.zero);
                        }
                        assets.add(asset);
                      }
                      return SlideshowPlayerPage(
                        assets: assets,
                      );
                    },
                  ),
                );
              }
            },
            icon: SvgPicture.asset('assets/icons/done.svg'),
          ),
        ],
      ),
    );
  }
}
