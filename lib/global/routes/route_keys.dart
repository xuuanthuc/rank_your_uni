import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

abstract class RouteKey {
  static const String search = "search";
  static const String home = "home";
  static const String university = "university";
  static const String review = "review";
  static const String compare = "compare";
  static const String compareWith = "compare_with";
  static const String reset = "reset_compare";
}

