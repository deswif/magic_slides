import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/magic_tap_editor/blocs/editor_bloc/magic_tap_editor_bloc.dart';
import 'package:magic_slides/magic_tap_editor/blocs/resize_bloc/resize_bloc.dart';
import 'package:magic_slides/magic_tap_editor/widgets/resize_lead_part.dart';

class ResizePage extends StatelessWidget {
  const ResizePage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResizeBloc(
        editorBloc: context.read<MagicTapEditorBloc>(),
        index: index,
      ),
      child: const ResizeView(),
    );
  }
}

class ResizeView extends StatefulWidget {
  const ResizeView({super.key});

  @override
  State<ResizeView> createState() => _ResizeViewState();
}

class _ResizeViewState extends State<ResizeView> {
  double zoom = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            _getBackground(context),
            GestureDetector(
              onTap: () {
                context.read<ResizeBloc>().add(PNGGestured(isActive: false));
              },
              onScaleEnd: (_) {
                final state = context.read<ResizeBloc>().state;
                if (zoom != 1) {
                  context.read<ResizeBloc>().add(
                        PNGScaled(
                          state.png.height * zoom,
                          state.png.width * zoom,
                        ),
                      );
                }
                zoom = 1;
              },
              onScaleUpdate: (details) {
                context.read<ResizeBloc>().add(PNGGestured(isActive: true));

                final state = context.read<ResizeBloc>().state;
                final scaledHalfHeight = state.png.height / 2 * zoom;
                final scaledHalfWidth = state.png.width / 2 * zoom;

                if (details.pointerCount > 1 &&
                    state.png.width * details.scale <=
                        MediaQuery.of(context).size.width &&
                    state.png.width * details.scale >= 20 &&
                    state.png.height * details.scale <=
                        MediaQuery.of(context).size.height &&
                    state.png.height * details.scale >= 20) {
                  zoom = details.scale;
                }

                var x = state.png.x;
                var y = state.png.y;

                y = max(
                  scaledHalfHeight,
                  y - details.focalPointDelta.dy,
                );

                y = min(
                  y,
                  MediaQuery.of(context).size.height - scaledHalfHeight,
                );

                x = max(
                  scaledHalfWidth,
                  x + details.focalPointDelta.dx,
                );
                x = min(
                  x,
                  MediaQuery.of(context).size.width - scaledHalfWidth,
                );

                context.read<ResizeBloc>().add(
                      PNGMoved(
                        x,
                        y,
                      ),
                    );
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    BlocBuilder<ResizeBloc, ResizeState>(
                      builder: (context, state) {
                        final scaledHalfHeight = state.png.height / 2 * zoom;
                        final scaledHalfWidth = state.png.width / 2 * zoom;
                        return Positioned(
                          left: state.png.x - scaledHalfWidth,
                          bottom: state.png.y - scaledHalfHeight,
                          child: Image.file(
                            state.png.file,
                            height: state.png.height * zoom,
                            width: state.png.width * zoom,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: BlocSelector<ResizeBloc, ResizeState, bool>(
                selector: (state) {
                  return state.isActive;
                },
                builder: (context, state) {
                  Widget widget;

                  if (state) {
                    widget = const SizedBox();
                  } else {
                    widget = const Align(
                      alignment: Alignment.topCenter,
                      child: ResizeLeadPart(),
                    );
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: widget,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getBackground(BuildContext context) {
    final background = context.read<MagicTapEditorBloc>().state.background;
    if (background != null) {
      return Center(child: Image.file(background));
    }

    return const SizedBox();
  }
}
