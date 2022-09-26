import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ui/onboarding_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PLANT CARE',
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
