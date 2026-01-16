import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static const _fontFamily = 'mulish';

  static TextStyle headline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 38.sp,
    fontWeight: FontWeight.w800,
    color: const Color(0xFF0F274A),
  );

  static TextStyle title = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0F274A),
  );

  static TextStyle body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    height: 1.5,
    color: const Color(0xFF0F274A),
  );

  static TextStyle bodyMuted = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    color: const Color(0xFF0F274A).withOpacity(0.6),
  );

  static TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static TextStyle badge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}
