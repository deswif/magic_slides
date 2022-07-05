import 'package:flutter/material.dart';
import 'package:magic_slides/theme/magic_colors.dart';
import 'package:magic_slides/theme/magic_text_theme.dart';

class MagicTheme {
  static ThemeData get standard {
    return ThemeData(
      fontFamily: 'Inter',
      scaffoldBackgroundColor: MagicColors.darkGrey,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: MagicColors.pink,
          onPrimary: Colors.black,
          shadowColor: Colors.transparent,
        ).copyWith(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
      textTheme: MagicTextScheme.standard,
    );
  }
}
