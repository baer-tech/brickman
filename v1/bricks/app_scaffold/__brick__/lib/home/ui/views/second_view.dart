import 'package:flutter/material.dart';

class SecondView extends StatelessWidget {
  static const routeName = '/second';

  const SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Second view",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
