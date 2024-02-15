import 'package:flutter/material.dart';

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
          bodyText1: TextStyle(
            color: Colors.black,
          ),
      
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red
          ),
        ),
     
      ),
      title: 'welcome',
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: const Color.fromARGB(255, 236, 230, 230),
      body: Center(
        child: Text(
          'WaraChow',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
