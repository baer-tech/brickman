import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/l10n/l10n.dart';
import '/router.dart';
import '/theme/app_theme.dart';
import '/home/ui/views/home_view.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.read(appThemeProvider);
    final router = ref.read(routerProvider);

    Future.delayed(const Duration(seconds: 3), () {
      if (ref.read(routerProvider).location == "/") {
        ref.read(routerProvider).go(HomeView.routeName);
      }
    });

    return MaterialApp.router(
      title: "Brickman demo app",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
