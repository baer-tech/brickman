import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/colored_text_widget.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  static const routeName = '/main';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Text(routeName),
            ColoredTextWidget(),
          ],
        ),
      ),
    );
  }
}