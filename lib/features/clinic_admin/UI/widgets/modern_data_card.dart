// widgets/modern_data_card.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/spacing.dart';

class ModernDataCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isEditing;

  const ModernDataCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onEdit,
    required this.onDelete,
    this.isEditing = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 600.w),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isEditing 
              ? AppColors.primary.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isEditing 
                ? AppColors.primary.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            width: isEditing ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondary.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, color: AppColors.primary),
              onPressed: onEdit,
              tooltip: 'Edit',
            ),
            horizontalSpace(4),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7)),
              onPressed: onDelete,
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}