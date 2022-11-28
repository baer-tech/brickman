import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/main';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Another brick in the wall...",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
