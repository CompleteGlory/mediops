import 'package:flutter/material.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/features/onboarding/onboarding_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const MediOpsOnboarding());
      default:
        null;
    }
    return null;
  }
}