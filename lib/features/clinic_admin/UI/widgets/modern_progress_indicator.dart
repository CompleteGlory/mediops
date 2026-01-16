// widgets/modern_progress_indicator.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/spacing.dart';

class ModernProgressIndicator extends StatelessWidget {
  final int currentStep;
  final List<bool> completed;

  const ModernProgressIndicator({
    required this.currentStep,
    required this.completed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: List.generate(4, (index) {
          final isDone = completed[index];
          final isActive = index == currentStep;
          final isPassed = index < currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: isDone || isPassed
                          ? LinearGradient(
                              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                            )
                          : null,
                      color: isDone || isPassed
                          ? null
                          : isActive
                              ? AppColors.primary.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ),
                if (index < 3) horizontalSpace(8),
              ],
            ),
          );
        }),
      ),
    );
  }
}