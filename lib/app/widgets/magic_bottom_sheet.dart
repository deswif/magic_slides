import 'package:flutter/material.dart';
import 'package:magic_slides/theme/theme.dart';

class MagicBottomSheet extends StatelessWidget {
  const MagicBottomSheet({
    super.key,
    required this.child,
    this.height,
  });

  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          color: Theme.of(context).colorScheme.card,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                width: 70,
                height: 3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: MagicColors.pink,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 650,
              ),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
