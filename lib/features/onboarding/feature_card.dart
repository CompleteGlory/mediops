import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_text_styles.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final Color borderColor;
  final List<String> features;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.borderColor,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.all(26.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Text(
            title,
            style: AppTextStyles.title.copyWith(
              color: borderColor,
              fontSize: 26.sp,
            ),
          ),

          SizedBox(height: 6.h),

          /// SUBTITLE (PRICE / FREE)
          Text(
            subtitle,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
              color: const Color(0xFF0F274A).withOpacity(0.75),
            ),
          ),

          SizedBox(height: 14.h),

          /// DESCRIPTION
          Text(
            description,
            style: AppTextStyles.bodyMuted.copyWith(
              fontSize: 15.sp,
              height: 1.5,
            ),
          ),

          SizedBox(height: 22.h),

          /// FEATURES
          Expanded(
            child: Column(
              children: features.map((feature) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 20.sp,
                        color: borderColor,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          feature,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 15.sp,
                            color:
                                const Color(0xFF0F274A).withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
