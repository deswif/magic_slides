import 'package:flutter/material.dart';
import 'package:magic_slides/theme/magic_colors.dart';

extension MagicColorScheme on ColorScheme {
  Color get topSheet => MagicColors.pink.withOpacity(0.8);
  Color get homeIcon => Colors.black;
  Color get background => MagicColors.darkGrey;
  Color get card => MagicColors.lightGrey;
  Color get deleteIcon => const Color(0xFFFF6060);
}
