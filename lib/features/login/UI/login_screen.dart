// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';
import 'package:mediops/features/login/UI/widgets/login_bloc_listener.dart';
import 'package:mediops/features/login/logic/cubit/login_cubit.dart';
import 'package:mediops/features/register/UI/register_screen.dart';

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
      body: Form(
        key: loginCubit.formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  // LOGO
                  Image.asset('assets/images/mediops light.png', height: 150.h),
                  SizedBox(height: 32.h),
        
                  // TITLE
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Login to manage your clinic',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 16.sp,
                      color: AppColors.secondary.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
        
                  // USER NAME FIELD
                  AppTextField(
                    label: 'User Name',
                    controller: loginCubit.userNameController,
                    keyboardType: TextInputType.name,
                    onChanged: (val) {
                      // handle user name changes if needed
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'User Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
        
                  // PASSWORD FIELD
                  AppTextField(
                    label: 'Password',
                    controller: loginCubit.passwordController,
                    obscureText: loginCubit.obscurePassword,
                    onChanged: (val) {
                      // handle password strength if needed
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    // Add a suffix icon for show/hide
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginCubit.obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.secondary.withOpacity(0.7),
                      ),
                      onPressed: () {
                        setState(() {
                          loginCubit.obscurePassword = !loginCubit.obscurePassword;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),      
                  // LOGIN BUTTON
                  AppPrimaryButton(
                    text: 'Login',
                    onPressed: () {
                      context.read<LoginCubit>().login();
                    },
                  ),
                  SizedBox(height: 16.h),
        
                  // REGISTER LINK
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(
                        fontFamily: 'mulish',
                        fontSize: 14.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                LoginBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
