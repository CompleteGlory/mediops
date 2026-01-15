// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/helpers/extensions.dart';
import 'package:mediops/core/routing/routes.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/themes/app_text_styles.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/features/login/UI/login_screen.dart';
import 'package:mediops/features/onboarding/feature_card.dart';


class MediOpsOnboarding extends StatelessWidget {
  const MediOpsOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    final cardHeight = 470.h;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            children: [
              /// FREE TRIAL BADGE
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Text(
                  '🎉 1 Month Free Trial • No Credit Card Required',
                  style: AppTextStyles.badge,
                ),
              ),

              SizedBox(height: 32.h),

              Image.asset(
                'assets/images/mediops light.png',
                height: 190.h,
              ),

              SizedBox(height: 28.h),

              Text(
                'Run Your Clinic Like a Business',
                style: AppTextStyles.headline,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 14.h),

              Text(
                'Appointments, patients, payments, and growth — all in one system.',
                style: AppTextStyles.bodyMuted.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.textPrimary.withOpacity(0.75),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 52.h),

              isWide
                  ? Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: cardHeight,
                            child: const FeatureCard(
                              title: 'For Patients',
                              subtitle: 'Always Free',
                              description:
                                  'iOS & Android apps\nSmart reminders & booking',
                              borderColor: AppColors.borderLight,
                              features: [
                                'Easy booking',
                                'WhatsApp reminders',
                                'Medical history',
                                'Free forever',
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 32.w),
                        Expanded(
                          child: SizedBox(
                            height: cardHeight,
                            child: const FeatureCard(
                              title: 'For Clinics',
                              subtitle: '500 EGP / month',
                              description:
                                  'All-in-one management system\nMobile & web',
                              borderColor: AppColors.secondary,
                              features: [
                                '1 month free trial',
                                'Sales & profit tracking',
                                'Scheduling & staff',
                                'Patient analytics',
                                'Referrals & packages',
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: cardHeight,
                          child: const FeatureCard(
                            title: 'For Patients',
                            subtitle: 'Always Free',
                            description:
                                'iOS & Android apps\nSmart reminders & booking',
                            borderColor: AppColors.borderLight,
                            features: [
                              'Easy booking',
                              'WhatsApp reminders',
                              'Medical history',
                              'Free forever',
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),
                        SizedBox(
                          height: cardHeight,
                          child: const FeatureCard(
                            title: 'For Clinics',
                            subtitle: '500 EGP / month',
                            description:
                                'All-in-one management system\nMobile & web',
                            borderColor: AppColors.secondary,
                            features: [
                              '1 month free trial',
                              'Sales & profit tracking',
                              'Scheduling & staff',
                              'Patient analytics',
                              'Referrals & packages',
                            ],
                          ),
                        ),
                      ],
                    ),

              SizedBox(height: 60.h),

              AppPrimaryButton(
                text: 'Start Free Trial',
                onPressed: () {
                 context.pushNamed(
                   Routes.register,
                  );
                },
              ),

              SizedBox(height: 18.h),

              Text(
                'No credit card required • Cancel anytime',
                style: AppTextStyles.bodyMuted.copyWith(
                  color: AppColors.textMuted.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
