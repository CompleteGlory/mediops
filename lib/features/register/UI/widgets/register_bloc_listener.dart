import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/features/register/data/models/register_response.dart';
import 'package:mediops/features/register/logic/cubit/register_cubit.dart';
import 'package:mediops/features/register/logic/cubit/register_state.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState<RegisterResponse>>(
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
          success: (registerResponse) {
            Navigator.of(context, rootNavigator: true).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful! Please login.'),
                backgroundColor: Colors.green,
              ),
            );

            // ✅ NAVIGATE TO LOGIN
            Navigator.pushReplacementNamed(context, Routes.login);
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
