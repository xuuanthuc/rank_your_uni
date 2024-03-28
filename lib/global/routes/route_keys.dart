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
  static const String searchUniversity = "search_university";
  static const String searchProfessor = "search_professor";
  static const String home = "home";
  static const String dashboard = "dashboard";
  static const String authDashboard = "auth_dashboard";
  static const String university = "university";
  static const String review = "review";
  static const String editReview = "edit_review";
  static const String compare = "compare";
  static const String compareWith = "compare_with";
  static const String reset = "reset_compare";
  static const String profile = "profile";
  static const String account = "account";
  static const String yourRating = "youRating";
  static const String guidelines = "guidelines";
  static const String helps = "helps";
  static const String addUniversity = "add_university";
  static const String addProfessor = "add_professor";
  static const String reviewSuccess = "review_success";
  static const String deteleSuccess = "delete_success";
  static const String terms = "terms_of_service";
  static const String policy = "privacy_policy";
  static const String resetPassword = "reset_password";
}

