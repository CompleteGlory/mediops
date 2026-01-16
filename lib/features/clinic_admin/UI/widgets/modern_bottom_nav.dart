// widgets/modern_bottom_nav.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';

class ModernBottomNav extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final bool canProceed;

  const ModernBottomNav({
    required this.currentStep,
    required this.onNext,
    required this.canProceed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: AppPrimaryButton(
          text: currentStep == 3 ? 'Finish Setup' : 'Continue',
          onPressed: canProceed ? onNext : (){},
        ),
      ),
    );
  }
}