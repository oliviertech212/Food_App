import 'package:flutter/material.dart';
import 'package:foodapp/pages/home.dart';
import 'package:foodapp/pages/login.dart';
import 'package:foodapp/utils/theme.dart';
import 'package:foodapp/pages/signup.dart';

void main() {
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: foodApptheme,
      title: 'welcome',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/': (context) => const LoginPage(),
        '/signup': (context) => const MySignupPage(),
      },
    );
  }
}
