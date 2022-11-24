import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/main/ui/main_page.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: MainPage.routeName,
      routes: [
        GoRoute(
          path: MainPage.routeName,
          builder: (context, state) => const MainPage(),
        ),
      ],
    );
  },
);
