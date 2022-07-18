import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_slides/app/widgets/error_dialog.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/magic_tap_editor/blocs/editor_bloc/magic_tap_editor_bloc.dart';
import 'package:magic_slides/magic_tap_editor/models/png_model.dart';
import 'package:magic_slides/magic_tap_player/view/view.dart';
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

    return Row(
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
            if (!isBackgroundValid(context)) {
              await showDialog<void>(
                context: context,
                builder: (context) {
                  return const ErrorDialog(
                    message: "Background can't be empty",
                  );
                },
              );
            } else if (!isPNGsValid(context)) {
              await showDialog<void>(
                context: context,
                builder: (context) {
                  return const ErrorDialog(
                    message:
                        'All PNGs must be filled. Minimal amount of PNGs is 2',
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
              context.read<MagicTapEditorBloc>().add(
                    NameChanged(name: _controller.text.trim()),
                  );
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (_) {
                    final pngs = <Png>[];
                    for (final png
                        in context.read<MagicTapEditorBloc>().state.pngs) {
                      if (png != null) {
                        pngs.add(png);
                      }
                    }
                    return MagicTapPlayerPage(
                      background:
                          context.read<MagicTapEditorBloc>().state.background!,
                      pngs: pngs,
                    );
                  },
                ),
              );
            }
          },
          icon: SvgPicture.asset('assets/icons/done.svg'),
        ),
      ],
    );
  }

  bool isBackgroundValid(BuildContext context) {
    final bg = context.read<MagicTapEditorBloc>().state.background;
    return bg != null;
  }

  bool isPNGsValid(BuildContext context) {
    final pngs = context.read<MagicTapEditorBloc>().state.pngs;

    if (pngs.length < 2) return false;

    var valid = true;
    for (final png in pngs) {
      if (png == null) {
        valid = false;
        break;
      }
    }
    return valid;
  }
}
