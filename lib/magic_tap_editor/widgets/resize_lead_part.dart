import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_slides/magic_tap_editor/blocs/resize_bloc/resize_bloc.dart';
import 'package:magic_slides/theme/theme.dart';

class ResizeLeadPart extends StatelessWidget {
  const ResizeLeadPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.card,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -4),
            spreadRadius: 4,
            blurRadius: 4,
            color: Colors.black.withOpacity(0.7),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/cross.svg'),
          ),
          IconButton(
            onPressed: () {
              context.read<ResizeBloc>().add(PNGSavePressed());
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/done.svg'),
          ),
        ],
      ),
    );
  }
}
