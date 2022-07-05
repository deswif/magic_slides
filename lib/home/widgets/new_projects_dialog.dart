import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_slides/home/bloc/home_bloc.dart';

class NewProjectDialog extends StatelessWidget {
  const NewProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.27,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 69,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(SlidesClicked());
                  },
                  child: const Center(
                    child: Text(
                      'Slide Show',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 69,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(MagicTapClicked());
                  },
                  child: const Center(
                    child: Text(
                      'Magic Tap',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
