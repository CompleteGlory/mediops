import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/helpers/app_regex.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';
import 'package:mediops/core/widgets/password_strength_bar.dart';
import 'package:mediops/core/widgets/spacing.dart';
import 'package:mediops/features/register/logic/cubit/client_register_cubit.dart';
import 'package:mediops/features/register/logic/cubit/client_register_state.dart';
import 'package:mediops/features/register/data/models/client_register_response.dart';

class ClientRegisterForm extends StatefulWidget {
  const ClientRegisterForm({super.key});

  @override
  State<ClientRegisterForm> createState() => _ClientRegisterFormState();
}

class _ClientRegisterFormState extends State<ClientRegisterForm> {
  bool obscurePassword = true;
  int passwordStrengthValue = 0;

  void _updatePasswordStrength(String password) {
    int strength = 0;
    if (AppRegex.hasLowerCase(password)) strength++;
    if (AppRegex.hasUpperCase(password)) strength++;
    if (AppRegex.hasNumber(password)) strength++;
    if (AppRegex.hasSpecialCharacter(password)) strength++;
    if (AppRegex.hasMinLength(password)) strength++;
    setState(() {
      passwordStrengthValue = strength;
    });
  }

  Color _getStrengthColor() {
    switch (passwordStrengthValue) {
      case 5:
        return Colors.green;
      case 4:
        return Colors.lightGreen;
      case 3:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  String _getStrengthText() {
    switch (passwordStrengthValue) {
      case 5:
        return 'Strong';
      case 4:
        return 'Good';
      case 3:
        return 'Weak';
      default:
        return 'Very Weak';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientRegisterCubit, ClientRegisterState<ClientRegisterResponse>>(
      builder: (context, state) {
        final clientRegisterCubit = context.read<ClientRegisterCubit>();
        return Form(
          key: clientRegisterCubit.formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'Username',
                controller: clientRegisterCubit.usernameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Username is required'
                    : null,
              ),
              verticalSpace(16),
              AppTextField(
                label: 'Password',
                controller: clientRegisterCubit.passwordController,
                obscureText: obscurePassword,
                onChanged: _updatePasswordStrength,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Password is required';
                  if (!AppRegex.isPasswordValid(value)) return 'Weak password';
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.secondary.withOpacity(0.6),
                  ),
                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                ),
              ),
              verticalSpace(10),
              PasswordStrengthBar(
                color: _getStrengthColor(),
                strength: passwordStrengthValue,
                text: _getStrengthText(),
              ),
              verticalSpace(28),
              AppPrimaryButton(
                text: 'Register as Client',
                onPressed: () => clientRegisterCubit.registerClient(),
              ),
            ],
          ),
        );
      },
    );
  }
}
