import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/helpers/constants.dart';
import 'package:mediops/core/helpers/shared_pref_helper.dart';
import 'package:mediops/core/networks/dio_factory.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/features/login/data/models/login_reponse.dart';
import 'package:mediops/features/login/logic/cubit/login_cubit.dart';
import 'package:mediops/features/login/logic/cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState<LoginResponse>>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) =>
                  const Center(child: CircularProgressIndicator()),
            );
          },
          success: (loginResponse) {
            Navigator.of(context, rootNavigator: true).pop();

            // ✅ SAVE TOKEN
            if (loginResponse.token != null) {
              SharedPrefHelper.setData(
                SharedPrefKeys.userToken,
                loginResponse.token,
              );
              DioFactory.setTokenIntoHeaderAfterLogin(loginResponse.token ?? '');

              // ✅ NAVIGATE BASED ON PERMISSION
              String route;
              
              if (loginResponse.permission == 0) {
                // Permission 0: Patient/Public user (limited access)
                route = Routes.patient;
              } else if (loginResponse.permission == 1) {
                // Permission 1: Therapist (moderate access)
                route = Routes.therapist;
              } else if ((loginResponse.permission ?? 0) >= 2) {
                // Permission >= 2: Administrator/Secretary (full access)
                route = Routes.clinicAdmin;
              } else {
                route = Routes.login;
              }
              
              // Remove all previous routes from stack to prevent back navigation
              Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
            } else {
              // Token is missing, show error
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Authentication failed check your credentials !.'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 4),
                ),
              );
            }
          },
          failure: (message) {
            // Close the loading dialog if it exists
            if (Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}




