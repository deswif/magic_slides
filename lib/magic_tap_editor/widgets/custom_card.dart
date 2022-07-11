import 'package:flutter/material.dart';
import 'package:magic_slides/theme/theme.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 131,
      width: 57,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 3),
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      child: child,
    );
  }
}
