import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/colored_text_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const routeName = '/main';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(routeName),
            ColoredTextWidget(),
          ],
        ),
      ),
    );
  }
}
