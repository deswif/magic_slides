import 'package:flutter/material.dart';

class NewProjectButton extends StatelessWidget {
  const NewProjectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              'New project',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
      ),
    );
  }
}
