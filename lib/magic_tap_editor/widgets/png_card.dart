import 'package:flutter/material.dart';
import 'package:magic_slides/magic_tap_editor/widgets/widgets.dart';
import 'package:magic_slides/theme/theme.dart';

class PNGCard extends StatelessWidget {
  const PNGCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 15,
            child: Text(
              index.toString(),
              style: Theme.of(context).textTheme.title,
            ),
          ),
          const CustomCard(),
          SizedBox(
            height: 66,
            width: 136,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Pick PNG',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: ElevatedButton(onPressed: () {}, child: const Text('-')),
          )
        ],
      ),
    );
  }
}
