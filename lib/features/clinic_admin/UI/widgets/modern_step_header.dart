// widgets/modern_step_header.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/spacing.dart';

class ModernStepHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const ModernStepHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 40.sp, color: iconColor),
        ),
        verticalSpace(16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
        verticalSpace(8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.secondary.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}