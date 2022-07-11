import 'package:flutter/material.dart';
import 'package:magic_slides/magic_tap_editor/widgets/custom_card.dart';
import 'package:magic_slides/magic_tap_editor/widgets/png_card.dart';

class AssetsList extends StatelessWidget {
  const AssetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: CustomCard(),
              ),
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                height: 66,
                width: 166,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Pick background',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          children: _widgets(context),
        )
      ],
    );
  }

  List<Widget> _widgets(BuildContext context) {
    final list = <Widget>[];
    for (var i = 0; i < 3; i++) {
      list.add(
        PNGCard(
          index: i + 1,
          key: ValueKey(i),
        ),
      );
    }
    return list;
  }
}
