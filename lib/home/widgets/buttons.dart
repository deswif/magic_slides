import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_slides/home/bloc/home_bloc.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 61),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 69,
              child: ElevatedButton(
                onPressed: () {
                  context.read<HomeBloc>().add(NewProjectClicked());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'New Project',
                        ),
                        SvgPicture.asset('assets/icons/add.svg')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            SizedBox(
              height: 69,
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Existing projects',
                        ),
                        SvgPicture.asset('assets/icons/gallery.svg')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            SizedBox(
              height: 42,
              width: 80,
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Center(
                    child: SvgPicture.asset('assets/icons/help.svg'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
