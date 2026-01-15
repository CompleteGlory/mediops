// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/helpers/app_regex.dart';
import 'package:mediops/core/helpers/extensions.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';
import 'package:mediops/core/widgets/auth_form_container.dart';
import 'package:mediops/core/widgets/password_strength_bar.dart';
import 'package:mediops/core/widgets/spacing.dart';
import 'package:mediops/features/register/logic/cubit/register_cubit.dart';
import 'package:mediops/features/register/UI/widgets/register_bloc_listener.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegistersScreenState();
}

class _RegistersScreenState extends State<RegisterScreen> {
  bool obscurePassword = true;
  int passwordStrengthValue = 0;

  RegisterCubit get registerCubit => context.read<RegisterCubit>();

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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final formWidth = constraints.maxWidth > 600 ? 600.w : constraints.maxWidth * 0.95;
            final fieldWidth = 400.w;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: formWidth),
                  child: AuthFormContainer(
                    child: Form(
                      key: registerCubit.formKey,
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo white.png', height: 100.h),
                          verticalSpace(20),

                          Text(
                            'Register Your Clinic',
                            style: TextStyle(
                              fontFamily: 'mulish',
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          verticalSpace(6),
                          Text(
                            'Manage patients, appointments & payments',
                            style: TextStyle(
                              fontFamily: 'mulish',
                              fontSize: 14.sp,
                              color: AppColors.secondary.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          verticalSpace(28),

                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: AppTextField(
                              label: 'Clinic Name',
                              controller: registerCubit.clinicNameController,
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Clinic name is required'
                                  : null,
                            ),
                          ),
                          verticalSpace(16),

                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: AppTextField(
                              label: 'Password',
                              controller: registerCubit.passwordController,
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
                          ),
                          verticalSpace(10),

                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: PasswordStrengthBar(
                              color: _getStrengthColor(),
                              strength: passwordStrengthValue,
                              text: _getStrengthText(),
                            ),
                          ),
                          verticalSpace(28),

                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: AppPrimaryButton(
                              text: 'Register Clinic',
                              onPressed: () => registerCubit.register(),
                            ),
                          ),
                          verticalSpace(12),

                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: TextButton(
                              onPressed: () => context.pushNamed(Routes.login),
                              child: Text(
                                'Already have an account? Login',
                                style: TextStyle(
                                  fontFamily: 'mulish',
                                  fontSize: 13.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          const RegisterBlocListener(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
