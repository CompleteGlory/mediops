import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/di/dependency_injection.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/features/clinic_admin/UI/clinic_admin_screen.dart';
import 'package:mediops/features/login/UI/login_screen.dart';
import 'package:mediops/features/login/logic/cubit/login_cubit.dart';
import 'package:mediops/features/onboarding/onboarding_screen.dart';
import 'package:mediops/features/patient/UI/patient_screen.dart';
import 'package:mediops/features/register/UI/register_screen.dart';
import 'package:mediops/features/register/logic/cubit/register_cubit.dart';
import 'package:mediops/features/therapist/UI/therapist_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const MediOpsOnboarding());
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.patient:
        return MaterialPageRoute(
          builder: (_) => const PatientScreen(),
        );
      case Routes.therapist:
        return MaterialPageRoute(
          builder: (_) => const TherapistScreen(),
        );
      case Routes.clinicAdmin:
        return MaterialPageRoute(
          builder: (_) => const ClinicAdminScreen(),
        );
      default:
        null;
    }
    return null;
  }
}
