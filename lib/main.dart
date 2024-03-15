import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sehyogini_frontned/OnboardingScreens/accountType.dart';
import 'package:sehyogini_frontned/OnboardingScreens/signIn.dart';
import 'package:sehyogini_frontned/OnboardingScreens/signup.dart';
import 'package:sehyogini_frontned/OnboardingScreens/splashScreen.dart';
import 'package:sehyogini_frontned/Screens/pages/opportunity.dart';
import 'package:sehyogini_frontned/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          canvasColor: Colors.white,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.white,
              modalBackgroundColor: Colors.white,
              surfaceTintColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
