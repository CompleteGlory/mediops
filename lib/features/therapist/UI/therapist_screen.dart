// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';

class TherapistScreen extends StatelessWidget {
  const TherapistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Permission 1: Therapist (moderate access)
    // Features: My Schedule, Appointments, Sales
    
    return WillPopScope(
      onWillPop: () async {
        // Exit the app on back press
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Therapist Dashboard',
            style: TextStyle(
              fontFamily: 'mulish',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
        ),
        body: const SizedBox.expand(),
      ),
    );
  }
}
