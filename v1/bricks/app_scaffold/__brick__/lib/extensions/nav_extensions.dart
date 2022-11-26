import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: implementation_imports
import 'package:go_router/src/match.dart';

extension NavExtension on BuildContext {
  String get currentRoute => GoRouter.of(this).location;

  List<RouteMatch> get currentRouteStack => GoRouter.of(this).routerDelegate.currentConfiguration.matches;

  void navigate(String navRoute) {
    go(navRoute);
  }

  void pushToStack(String navRoute) {
    push(navRoute);
  }
}
