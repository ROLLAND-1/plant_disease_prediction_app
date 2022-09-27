import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/service/firebase_auth.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ui/onboarding_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'PLANT CARE',
      home: 
      AuthService.instance.isLoggedIn?
      const RootPage()
      :
      const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
