// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/helpers/extensions.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';
import 'package:mediops/core/widgets/auth_form_container.dart';
import 'package:mediops/core/widgets/spacing.dart';
import 'package:mediops/features/login/UI/widgets/login_bloc_listener.dart';
import 'package:mediops/features/login/logic/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final formWidth = constraints.maxWidth > 600 ? 600.w : constraints.maxWidth * 0.95;
            final fieldWidth = 400.w;

            return Form(
              key: loginCubit.formKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: formWidth),
                    child: AuthFormContainer(
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo white.png', height: 100.h),
                          verticalSpace(20),
              
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontFamily: 'mulish',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          verticalSpace(6),
                          Text(
                            'Login to manage your clinic',
                            style: TextStyle(
                              fontFamily: 'mulish',
                              fontSize: 14.sp,
                              color: AppColors.secondary.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          verticalSpace(28),
              
                          // USERNAME FIELD
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: AppTextField(
                              label: 'User Name',
                              controller: loginCubit.userNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'User Name is required' : null,
                            ),
                          ),
                          verticalSpace(16),
              
                          // PASSWORD FIELD
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: AppTextField(
                              label: 'Password',
                              controller: loginCubit.passwordController,
                              obscureText: loginCubit.obscurePassword,
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Password is required' : null,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  loginCubit.obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.secondary.withOpacity(0.6),
                                ),
                                onPressed: () {
                                  loginCubit.togglePasswordVisibility();
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          verticalSpace(28),
              
                          // LOGIN BUTTON
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: AppPrimaryButton(
                              text: 'Login',
                              onPressed: () => loginCubit.login(),
                            ),
                          ),
                          verticalSpace(12),
              
                          // REGISTER LINK
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: fieldWidth),
                            child: TextButton(
                              onPressed: () {
                               context.pushNamed(Routes.register);
                              },
                              child: Text(
                                "Don't have an account? Register",
                                style: TextStyle(
                                  fontFamily: 'mulish',
                                  fontSize: 13.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
              
                          const LoginBlocListener(),
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
