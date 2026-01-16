// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';

class PasswordStrengthBar extends StatelessWidget {
  final int strength; // 0..5
  final Color color;
  final String text;

  const PasswordStrengthBar({
    super.key,
    required this.strength,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final total = 5;
    final filled = strength.clamp(0, total);

    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth - 80.w; // leave space for text
        final segmentWidth = (barWidth - (total - 1) * 6.w) / total;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bar segments
            ...List.generate(total, (index) {
              final isFilled = index < filled;
              return Container(
                width: segmentWidth,
                height: 6.h,
                margin: EdgeInsets.only(right: index == total - 1 ? 0 : 6.w),
                decoration: BoxDecoration(
                  color: isFilled
                      ? color
                      : AppColors.secondary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              );
            }),

            SizedBox(width: 10.w),

            // Text label
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 12.sp,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
