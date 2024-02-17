import 'package:flutter/material.dart';
import 'package:foodapp/pages/home.dart';

void main() {
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //ignore: deprecated_member_use
        backgroundColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          // Regular
          bodyText1:
              TextStyle(color: Colors.red, fontFamily: 'Roboto', fontSize: 20),

          // Bold
          bodyText2: TextStyle(
              color: Colors.blue,
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold),

          // Italic
          subtitle1: TextStyle(
              color: Colors.green,
              fontFamily: 'Roboto',
              fontSize: 20,
              fontStyle: FontStyle.italic),

          // Bold Italic
          subtitle2: TextStyle(
              color: Colors.orange,
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ),
      title: 'welcome',
      home: const HomePage(),
    );
  }
}
