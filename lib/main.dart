import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/core/constant/color.dart';
import 'package:real_estate/features/dashboard/presentation/dashboard_screen.dart';
import 'package:real_estate/features/dashboard/presentation/widgets/animation_widgets/house_animated_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (ctx,_)=> MaterialApp(
          title: 'Real Estate',
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.orange,
                primary: Colors.orange,
                secondary: AppColors.secondary
              ),
              useMaterial3: true,
              fontFamily: 'Sen',
          ),
          home: const
          // EasyAnimatedOffset()
          DashboardScreen()
      ),
    );
  }
}



