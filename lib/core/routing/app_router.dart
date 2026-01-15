import 'package:flutter/material.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/features/login/UI/login_screen.dart';
import 'package:mediops/features/onboarding/onboarding_screen.dart';
import 'package:mediops/features/register/UI/register_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const MediOpsOnboarding());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen()); 
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen()); 
      default:
        null;
    }
    return null;
  }
}