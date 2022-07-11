import 'package:flutter/material.dart';
import 'package:magic_slides/theme/theme.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.input,
      ),
    );
  }
}
