import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_slides/theme/theme.dart';

class LeadPart extends StatelessWidget {
  const LeadPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
          color: Theme.of(context).colorScheme.topSheet,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(child: SvgPicture.asset('assets/icons/logo.svg')),
      ),
    );
  }
}
