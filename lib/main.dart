import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/functions/firebaseauthentication.dart';
import 'package:foodapp/pages/home.dart';
import 'package:foodapp/pages/login.dart';
import 'package:foodapp/pages/verifyemail.dart';
import 'package:foodapp/utils/theme.dart';
import 'package:foodapp/pages/signup.dart';
import 'package:foodapp/pages/forgot_password.dart';
import 'package:foodapp/pages/verification.dart';
import 'package:foodapp/pages/new_password.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseAuthenticationService firebaseAuthenticationService =
      FirebaseAuthenticationService();
  await firebaseAuthenticationService.initialize();
  runApp(const FoodApp());
}

class FoodApp extends StatefulWidget {
  const FoodApp({super.key});

  @override
  State<FoodApp> createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
  // var _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // scaffoldMessengerKey: _scaffoldKey,
      theme: foodApptheme,
      title: 'welcome',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const MySignupPage(),
        '/forgot-password': (context) => ForgotPassword(),
        '/verification': (context) => const verification(),
        '/new-password': (context) => const NewPassword(),
        '/verifyemail': (context) => const VerifyEmailScreen(),
      },
    );
  }
}
