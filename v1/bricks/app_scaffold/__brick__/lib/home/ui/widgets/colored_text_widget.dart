import 'package:flutter/material.dart';

class ColoredTextWidget extends StatelessWidget {
  const ColoredTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Just another brick in the wall...",
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
