import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splash/splash.dart';

import 'home/ui/main_page.dart';
import 'home/ui/views/second_view.dart';
import 'home/ui/views/home_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeContentNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      debugLogDiagnostics: kDebugMode,
      navigatorKey: _rootNavigatorKey,
      routes: [
        /* GoRoute(
          path: SplashPage.routeName,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (_, state) => const SplashPage(),
        ), */
        ShellRoute(
          navigatorKey: _homeContentNavigatorKey,
          builder: (_, __, child) => MainPage(child: child),
          routes: [
            GoRoute(
              path: HomeView.routeName,
              pageBuilder: (_, state) => NoTransitionPage<void>(key: state.pageKey, child: const HomeView()),
            ),
            GoRoute(
              path: SecondView.routeName,
              pageBuilder: (_, state) => NoTransitionPage<void>(key: state.pageKey, child: const SecondView()),
            ),
          ],
        )
      ],
      errorBuilder: (context, __) {
        WidgetsBinding.instance.addPostFrameCallback((_) => GoRouter.of(context).go(HomeView.routeName));

        return const SizedBox.shrink();
      },
    );
  },
);
