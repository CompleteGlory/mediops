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
            SharedPrefHelper.setData(
              SharedPrefKeys.userToken,
              loginResponse.token,
            );
            DioFactory.setTokenIntoHeaderAfterLogin(loginResponse.token);

            // ✅ NAVIGATE
            Navigator.pushReplacementNamed(context, Routes.home);
          },
          failure: (message) {
            Navigator.of(context, rootNavigator: true).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
