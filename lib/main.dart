import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/di/dependency_injection.dart';
import 'package:mediops/core/routing/app_router.dart';
import 'package:mediops/mediops_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setUpGetIt();
  runApp(MediopsApp(
    appRouter: AppRouter(),
  ));
}