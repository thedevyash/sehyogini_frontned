import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sehyogini_frontned/OnboardingScreens/accountType.dart';
import 'package:sehyogini_frontned/OnboardingScreens/signIn.dart';
import 'package:sehyogini_frontned/OnboardingScreens/signup.dart';
import 'package:sehyogini_frontned/OnboardingScreens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
    );
  }
}
