import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/magic_tap_editor/bloc/magic_tap_editor_bloc.dart';
import 'package:magic_slides/magic_tap_editor/widgets/widgets.dart';

class MagicTapEditorPage extends StatelessWidget {
  const MagicTapEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MagicTapEditorBloc(),
      child: const MagicTapEditorView(),
    );
  }
}

class MagicTapEditorView extends StatelessWidget {
  const MagicTapEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              const Expanded(child: AssetsList()),
            ],
          ),
        ),
      ),
    );
  }
}
