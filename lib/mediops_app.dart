import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/routing/app_router.dart';
import 'package:mediops/core/routing/navigation_services.dart';
import 'package:mediops/core/routing/routes.dart';


class MediopsApp extends StatelessWidget {
  final AppRouter appRouter;
  const MediopsApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
         navigatorKey: NavigationService.navigatorKey,
         onGenerateRoute: appRouter.generateRoute,
         initialRoute:  Routes.onBoarding,
            ),
      );
  }
}

