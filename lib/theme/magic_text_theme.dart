import 'package:flutter/material.dart';
import 'package:magic_slides/theme/magic_colors.dart';

extension MagicTextScheme on TextTheme {
  static TextTheme get standard {
    return const TextTheme(
      button: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  TextStyle get input => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  TextStyle get title => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  TextStyle get settings => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: MagicColors.pink,
      );

  TextStyle get inactiveSettings => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: MagicColors.pink.withOpacity(0.4),
      );

  TextStyle get fakeTime => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'SF Pro Text',
      );
}
