import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F9FF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              Text('Welcome Back', style: AppTextStyles.title),
              SizedBox(height: 8.h),
              Text(
                'Login to manage your clinic',
                style: AppTextStyles.bodyMuted,
              ),

              SizedBox(height: 40.h),

              AppTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 20.h),

              AppTextField(
                label: 'Password',
                controller: passwordController,
                obscureText: true,
              ),

              SizedBox(height: 40.h),

              Center(
                child: AppPrimaryButton(
                  text: 'Login',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
