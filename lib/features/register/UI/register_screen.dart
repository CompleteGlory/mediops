// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/helpers/extensions.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/auth_form_container.dart';
import 'package:mediops/core/widgets/spacing.dart';
import 'package:mediops/features/register/UI/widgets/client_register_form.dart';
import 'package:mediops/features/register/UI/widgets/client_register_bloc_listener.dart';
import 'package:mediops/features/register/UI/widgets/doctor_register_form.dart';
import 'package:mediops/features/register/UI/widgets/register_bloc_listener.dart';
import 'package:mediops/features/register/UI/widgets/clinic_register_form.dart';
import 'package:mediops/features/register/UI/widgets/doctor_register_bloc_listener.dart';

enum RegistrationType { clinic, doctor, client }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegistersScreenState();
}

class _RegistersScreenState extends State<RegisterScreen> {
  RegistrationType registrationType = RegistrationType.clinic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final formWidth = constraints.maxWidth > 600 ? 600.w : constraints.maxWidth * 0.95;

            return Center(
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
                          'Create Account',
                          style: TextStyle(
                            fontFamily: 'mulish',
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        verticalSpace(6),
                        Text(
                          'Select account type to continue',
                          style: TextStyle(
                            fontFamily: 'mulish',
                            fontSize: 14.sp,
                            color: AppColors.secondary.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(28),

                        // Registration Type Selector
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _RegistrationTypeButton(
                                    title: 'Clinic Admin',
                                    isSelected: registrationType == RegistrationType.clinic,
                                    onPressed: () => setState(() => registrationType = RegistrationType.clinic),
                                  ),
                                ),
                                horizontalSpace(12),
                                Expanded(
                                  child: _RegistrationTypeButton(
                                    title: 'Doctor',
                                    isSelected: registrationType == RegistrationType.doctor,
                                    onPressed: () => setState(() => registrationType = RegistrationType.doctor),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(12),
                            _RegistrationTypeButton(
                              title: 'Client',
                              isSelected: registrationType == RegistrationType.client,
                              onPressed: () => setState(() => registrationType = RegistrationType.client),
                            ),
                          ],
                        ),
                        verticalSpace(28),

                        // Show appropriate form based on registration type
                        if (registrationType == RegistrationType.clinic)
                          const ClinicRegisterForm()
                        else if (registrationType == RegistrationType.doctor)
                          const DoctorRegisterForm()
                        else
                          const ClientRegisterForm(),

                        verticalSpace(12),
                        TextButton(
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

                        const RegisterBlocListener(),
                        const DoctorRegisterBlocListener(),
                        const ClientRegisterBlocListener(),
                      ],
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

class _RegistrationTypeButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const _RegistrationTypeButton({
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.secondary.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'mulish',
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.secondary.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
