import 'package:flutter/material.dart';

import 'package:magic_slides/home/view/home_page.dart';
import 'package:magic_slides/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MagicTheme.standard,
      home: const HomePage(),
    );
  }
}
