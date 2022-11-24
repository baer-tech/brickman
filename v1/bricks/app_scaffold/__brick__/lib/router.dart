import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home/ui/home_page.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: HomePage.routeName,
      routes: [
        GoRoute(
          path: HomePage.routeName,
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  },
);
