import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/magic_tap_player/magic_tap_player.dart';

class MagicTapPlayerPage extends StatelessWidget {
  const MagicTapPlayerPage({
    super.key,
    required this.background,
    required this.pngs,
  });

  final File background;
  final List<File> pngs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MagicTapPlayerBloc(background: background, pngs: pngs),
      child: const MagicTapPlayerView(),
    );
  }
}

class MagicTapPlayerView extends StatelessWidget {
  const MagicTapPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MagicTapPlayerBloc, MagicTapPlayerState>(
        builder: (context, state) {
          if (state is MagicTapNextPNG) {
            return GestureDetector(
              onTap: () => context.read<MagicTapPlayerBloc>().add(
                    MagicTapPNGSwitched(),
                  ),
              child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Center(
                      child: Image.file(
                        context.read<MagicTapPlayerBloc>().background,
                      ),
                    ),
                    Center(
                      child: IndexedStack(
                        alignment: Alignment.center,
                        index: context.read<MagicTapPlayerBloc>().currentIndex,
                        children: _getPNGs(context),
                      ),
                    ),
                    Container(
                      height: 38,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            );
          } else if (state is MagicTapPlayerEnd) {
            Future.delayed(Duration.zero, () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const HomePage(),
                ),
              );
            });
            return const SizedBox();
          } else if (state is MagicTapPlayerInitial) {
            context.read<MagicTapPlayerBloc>().add(MagicTapPlayerStarted());
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  List<Widget> _getPNGs(BuildContext context) {
    final widgets = <Widget>[];
    final pngs = context.read<MagicTapPlayerBloc>().pngs;

    for (final png in pngs) {
      widgets.add(
        Image.file(png),
      );
    }

    return widgets;
  }
}
