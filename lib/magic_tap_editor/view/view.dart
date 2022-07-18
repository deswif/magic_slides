import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/magic_tap_editor/blocs/editor_bloc/magic_tap_editor_bloc.dart';
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
    );
  }
}
