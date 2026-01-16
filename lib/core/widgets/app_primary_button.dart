// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_text_styles.dart';


class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;

  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: 56.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            width: 2,
            color: Color(0xFF0F488E),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.black.withOpacity(0.15),
          elevation: 5,
        ),
        child: Text(
          text,
          style: AppTextStyles.button.copyWith(
            color: const Color(0xFF0F488E),
          ),
        ),
      ),
    );
  }
}
