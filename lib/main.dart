import 'package:flutter/material.dart';
import 'package:foodapp/pages/home.dart';
import 'package:foodapp/utils/theme.dart';

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
      home: const HomePage(),
    );
  }
}
