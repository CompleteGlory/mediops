// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/helpers/app_regex.dart';
import 'package:mediops/core/helpers/extensions.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegistersScreenState();
}

class _RegistersScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  int passwordStrengthValue = 0;

  // Calculate password strength using AppRegex
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
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // LOGO
                  Image.asset('assets/images/mediops light.png', height: 120.h),
                  SizedBox(height: 24.h),

                  Text(
                    'Register Your Clinic',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Sign up to manage appointments, patients, and payments efficiently.',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 16.sp,
                      color: AppColors.secondary.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),

                  AppTextField(
                    label: 'Clinic Name',
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Clinic name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  AppTextField(
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!AppRegex.isEmailValid(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  AppTextField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: obscurePassword,
                    onChanged: (val) {
                      _updatePasswordStrength(val); // <-- CALL THE METHOD HERE
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Password is required';
                      if (!AppRegex.isPasswordValid(value)) {
                        return 'Password must contain:\n- Min 8 chars\n- Upper & lower case\n- Number & special char';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.secondary.withOpacity(0.7),
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Password strength bar
                  Row(
                    children: [
                      Expanded(
                        flex: passwordStrengthValue,
                        child: Container(
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: _getStrengthColor(),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5 - passwordStrengthValue,
                        child: Container(
                          height: 6.h,
                          color: AppColors.secondary.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _getStrengthText(),
                        style: TextStyle(
                          fontFamily: 'mulish',
                          fontSize: 12.sp,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                  AppPrimaryButton(
                    text: 'Register Clinic',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Call Registers API
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => context.pushNamed(Routes.login),
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        fontFamily: 'mulish',
                        fontSize: 14.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
