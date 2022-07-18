import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/slideshow_editor/models/assets_model.dart';
import 'package:magic_slides/slideshow_editor/slideshow_editor.dart';

class SlideshowEditorPage extends StatelessWidget {
  const SlideshowEditorPage({super.key, required this.assets});

  final List<Assets> assets;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SlideshowEditorBloc(assets),
      child: const SlideshowEditorView(),
    );
  }
}

class SlideshowEditorView extends StatelessWidget {
  const SlideshowEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 55,
          bottom: 80,
        ),
        child: Center(
            child: Column(
          children: [
            LeadPart(),
            const Expanded(
              child: AssetsList(),
            ),
          ],
        )),
      ),
    );
  }
}
