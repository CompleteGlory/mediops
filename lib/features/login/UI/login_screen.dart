import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';
import 'package:mediops/features/register/UI/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                // LOGO
                Image.asset(
                  'assets/images/mediops light.png',
                  height: 150.h,
                ),
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

                // EMAIL FIELD
                AppTextField(
                  label: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    // handle email changes if needed
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // PASSWORD FIELD
                AppTextField(
                  label: 'Password',
                  controller: passwordController,
                  obscureText: obscurePassword,
                  onChanged: (val) {
                    // handle password strength if needed
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    return null;
                  },
                  // Add a suffix icon for show/hide
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.secondary.withOpacity(0.7),
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 40.h),

                // LOGIN BUTTON
                AppPrimaryButton(
                  text: 'Login',
                  onPressed: () {
                    // TODO: Call login API
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
